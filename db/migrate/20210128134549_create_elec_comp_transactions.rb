class CreateElecCompTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :elec_comp_transactions do |t|
      t.references :buyer, null: false, foreign_key: true
      t.references :rider, null: false, foreign_key: true
      t.references :electricity_provider, null: false, foreign_key: true
      t.string :electricity_bill_number
      t.datetime :date_transacted
      t.string :type_of_transaction
      t.datetime :date_paid
      t.integer :amount

      t.timestamps
    end
  end
end
