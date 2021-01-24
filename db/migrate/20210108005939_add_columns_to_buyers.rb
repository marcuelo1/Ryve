class AddColumnsToBuyers < ActiveRecord::Migration[6.0]
  def change
    add_column :buyers, :first_name, :string
    add_column :buyers, :last_name, :string
    add_column :buyers, :phone_number, :string
    add_column :buyers, :is_verified, :boolean
    add_column :buyers, :verification_code, :int
  end
end
