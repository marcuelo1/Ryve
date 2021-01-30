class CreateUtilityPendings < ActiveRecord::Migration[6.0]
  def change
    create_table :utility_pendings do |t|
      t.references :buyer, null: false, foreign_key: true
      t.string :bill_number
      t.references :provider, polymorphic: true, null: false
      t.string :type_of_transaction
      t.boolean :is_paid
      t.integer :amount

      t.timestamps
    end
  end
end
