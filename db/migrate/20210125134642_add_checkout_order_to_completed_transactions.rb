class AddCheckoutOrderToCompletedTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :completed_transactions, :checkout_order_id, :integer
  end
end
