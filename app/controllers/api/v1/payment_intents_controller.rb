class Api::V1::PaymentIntentsController < ApplicationController

	def create
		begin
			return render :json => {:message => "Required parameter: name"}, :status => :bad_request if !params[:name].present?
			return render :json => {:message => "Required parameter: email"}, :status => :bad_request if !params[:email].present?
			return render :json => {:message => "Email invalid"}, :status => :bad_request if !(params[:email] =~ URI::MailTo::EMAIL_REGEXP)
			return render :json => {:message => "Required parameter: address"}, :status => :bad_request if !params[:address].present?

			Stripe.api_key = Rails.application.credentials.stripe_secret_key
			intent = Stripe::PaymentIntent.create({
			  amount: 1200,
			  currency: 'USD',
			  shipping: {
			  	name: params[:name],
			  	address: {
			  		line1: params[:address]
			  	},
			  },
			  receipt_email: params[:email],
			  # Verify your integration in this guide by including this parameter
			  metadata: {integration_check: 'accept_a_payment'},
			})
			render :json => intent, :status => :ok
		rescue Exception => e
			puts e.message
			return render :json => {:message => e.message}, :status => :internal_server_error
		end
	end

end
