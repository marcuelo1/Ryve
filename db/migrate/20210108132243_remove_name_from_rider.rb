class RemoveNameFromRider < ActiveRecord::Migration[6.0]
  def change
    remove_column :riders, :name, :string
  end
end
