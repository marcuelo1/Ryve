class CreateCheckoutAdditionals < ActiveRecord::Migration[6.0]
  def change
    create_table :checkout_additionals do |t|
      t.references :additional, null: false, foreign_key: true
      t.references :checkout_product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
