class AddStripePayload < ActiveRecord::Migration[6.0]
  def change
  	add_column :orders, :stripe_payload, :text
  	add_column :orders, :uid, :string
  end
end
