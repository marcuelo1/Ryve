class RemoveNameFromBuyer < ActiveRecord::Migration[6.0]
  def change
    remove_column :buyers, :name, :string
  end
end
