class AddBuyerLocationToPendingOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :pending_orders, :buyer_location, null: false, foreign_key: true
  end
end
