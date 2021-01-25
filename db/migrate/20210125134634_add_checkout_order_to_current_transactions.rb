class AddCheckoutOrderToCurrentTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :current_transactions, :checkout_order_id, :integer
  end
end
