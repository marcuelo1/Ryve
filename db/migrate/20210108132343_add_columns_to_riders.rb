class AddColumnsToRiders < ActiveRecord::Migration[6.0]
  def change
    add_column :riders, :first_name, :string
    add_column :riders, :last_name, :string
    add_column :riders, :is_verified, :boolean
    add_column :riders, :phone_number, :string
    add_column :riders, :verification_code, :int
    add_column :riders, :address, :string
    add_column :riders, :plate_number, :string
  end
end
