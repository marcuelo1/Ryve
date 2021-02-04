class CreateCompletedTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :completed_transactions do |t|
      t.datetime :date
      t.references :rider, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.references :buyer_location, null: false, foreign_key: true

      t.timestamps
    end
  end
end
