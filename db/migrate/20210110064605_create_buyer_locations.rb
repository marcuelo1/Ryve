class CreateBuyerLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :buyer_locations do |t|
      t.float :longitude
      t.float :latitude
      t.string :name
      t.references :buyer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
