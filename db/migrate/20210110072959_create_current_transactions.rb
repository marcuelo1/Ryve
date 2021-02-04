class CreateCurrentTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :current_transactions do |t|
      t.string :status
      t.integer :time_remaining
      t.boolean :is_paid
      t.references :buyer, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :rider, null: false, foreign_key: true

      t.timestamps
    end
  end
end
