class CreateUtilityCompleteds < ActiveRecord::Migration[6.0]
  def change
    create_table :utility_completeds do |t|
      t.references :buyer, null: false, foreign_key: true
      t.references :rider, null: false, foreign_key: true
      t.string :bill_number
      t.references :provider, polymorphic: true, null: false
      t.datetime :date_transacted
      t.string :type_of_transaction
      t.datetime :date_paid
      t.integer :amount

      t.timestamps
    end
  end
end
