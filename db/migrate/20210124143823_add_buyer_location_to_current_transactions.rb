class AddBuyerLocationToCurrentTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :current_transactions, :buyer_location, null: false, foreign_key: true
  end
end
