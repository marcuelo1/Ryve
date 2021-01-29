class CreateWaterCompTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :water_comp_transactions do |t|
      t.references :buyer, null: false, foreign_key: true
      t.references :rider, null: false, foreign_key: true
      t.string :water_bill_number
      t.references :water_provider, null: false, foreign_key: true
      t.datetime :date_transacted
      t.string :type_of_transaction
      t.datetime :date_paid
      t.integer :amount

      t.timestamps
    end
  end
end
