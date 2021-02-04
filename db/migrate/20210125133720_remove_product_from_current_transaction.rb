class RemoveProductFromCurrentTransaction < ActiveRecord::Migration[6.0]
  def change
    remove_reference :current_transactions, :product, null: false, foreign_key: true
  end
end
