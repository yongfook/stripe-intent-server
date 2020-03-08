class CreatePaymentIntents < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_intents do |t|

      t.timestamps
    end
  end
end
