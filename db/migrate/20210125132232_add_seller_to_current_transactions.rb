class AddSellerToCurrentTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :current_transactions, :seller, null: false, foreign_key: true
  end
end
