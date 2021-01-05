class RemoveNameFromSellerUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :seller_users, :name, :string
  end
end
