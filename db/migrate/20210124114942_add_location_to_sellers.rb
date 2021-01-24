class AddLocationToSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :location, :string
  end
end
