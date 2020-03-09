class Api::V1::OrdersController < ApplicationController
	before_action :authenticate_stripe_webhook, :only => :create

	def create
		puts "Saving Stripe object to DB"
		Order.create(:stripe_payload => @payment_intent)
	end

	def index
		#of course in the real world this would be protected somehow
		return render :json => Order.all.order(:created_at => "DESC")

	end

	def authenticate_stripe_webhook
		begin
			payload = request.body.read
			sig_header = request.env['HTTP_STRIPE_SIGNATURE']
			endpoint_secret = Rails.application.credentials.stripe_webhook_key
			event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
			if event.type == "payment_intent.succeeded"
				@payment_intent = event.data.object # contains a Stripe::PaymentIntent
				puts 'PaymentIntent was successful!'
			else
				status 400
				return
			end
		rescue JSON::ParserError => e
			puts e.message
	    # Invalid payload
	    status 400
	    return
	  rescue Stripe::SignatureVerificationError => e
	  	puts e.message
	    # Invalid signature
	    status 400
	    return
	  end
	end
end
