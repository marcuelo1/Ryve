class CreateCheckoutProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :checkout_products do |t|
      t.references :product, null: false, foreign_key: true
      t.references :checkout_order, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
