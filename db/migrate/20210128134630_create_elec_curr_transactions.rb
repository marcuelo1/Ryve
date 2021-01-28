class CreateElecCurrTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :elec_curr_transactions do |t|
      t.references :buyer, null: false, foreign_key: true
      t.references :rider, null: false, foreign_key: true
      t.references :electricity_provider, null: false, foreign_key: true
      t.string :electricity_bill_number
      t.string :status
      t.string :type_of_transaction
      t.boolean :is_paid
      t.integer :amount

      t.timestamps
    end
  end
end
