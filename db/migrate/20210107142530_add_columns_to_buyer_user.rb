class AddColumnsToBuyerUser < ActiveRecord::Migration[6.0]
  def change
    add_column :buyer_users, :first_name, :string
    add_column :buyer_users, :last_name, :string
    add_column :buyer_users, :phone_number, :string
    add_column :buyer_users, :is_verified, :boolean
    add_column :buyer_users, :verification_code, :int
  end
end
