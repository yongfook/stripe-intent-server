class ApplicationController < ActionController::API

	def create

		begin
			Stripe.api_key = Rails.application.credentials.stripe_secret_key
			intent = Stripe::PaymentIntent.create({
			  amount: 1200,
			  currency: 'USD',
			  # Verify your integration in this guide by including this parameter
			  metadata: {integration_check: 'accept_a_payment'},
			})
			render :json => intent, :status => :ok
		rescue Exception => e
			return render :json => {:message => e.message}, :status => :internal_server_error
		end
	end

end
