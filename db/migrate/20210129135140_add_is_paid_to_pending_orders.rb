class AddIsPaidToPendingOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :pending_orders, :is_paid, :boolean
  end
end
