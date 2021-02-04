class CreateSizes < ActiveRecord::Migration[6.0]
  def change
    create_table :sizes do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.integer :price
      t.integer :discount

      t.timestamps
    end
  end
end
