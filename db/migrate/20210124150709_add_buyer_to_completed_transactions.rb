class AddBuyerToCompletedTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :completed_transactions, :buyer, null: false, foreign_key: true
  end
end
