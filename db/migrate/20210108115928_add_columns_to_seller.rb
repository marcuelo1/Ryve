class AddColumnsToSeller < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :comapny_name, :string
    add_column :sellers, :phone_number, :string
    add_column :sellers, :is_verified, :boolean
    add_column :sellers, :longitude, :float
    add_column :sellers, :latitude, :float
    add_column :sellers, :verification_code, :int
    add_column :sellers, :category, :string
  end
end
