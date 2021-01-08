class RemoveNameFromBuyerUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :buyer_users, :name, :string
  end
end
