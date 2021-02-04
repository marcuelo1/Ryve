class CreateCheckoutSizes < ActiveRecord::Migration[6.0]
  def change
    create_table :checkout_sizes do |t|
      t.references :size, null: false, foreign_key: true
      t.references :checkout_product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
