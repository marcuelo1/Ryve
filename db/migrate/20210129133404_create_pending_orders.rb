class CreatePendingOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :pending_orders do |t|
      t.references :buyer, null: false, foreign_key: true
      t.references :seller, null: false, foreign_key: true
      t.integer :checkout_order_id

      t.timestamps
    end
  end
end
