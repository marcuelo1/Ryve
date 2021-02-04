class RemoveProductFromCompletedTransaction < ActiveRecord::Migration[6.0]
  def change
    remove_reference :completed_transactions, :product, null: false, foreign_key: true
  end
end
