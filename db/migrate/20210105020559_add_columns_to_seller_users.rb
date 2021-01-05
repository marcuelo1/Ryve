class AddColumnsToSellerUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :seller_users, :company_name, :string
    add_column :seller_users, :phone_number, :string
    add_column :seller_users, :is_verified, :boolean
    add_column :seller_users, :longitude, :float
    add_column :seller_users, :latitude, :float
  end
end
