class CreateCheckoutOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :checkout_orders do |t|

      t.timestamps
    end
  end
end
