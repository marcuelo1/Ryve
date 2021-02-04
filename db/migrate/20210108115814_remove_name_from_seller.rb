class RemoveNameFromSeller < ActiveRecord::Migration[6.0]
  def change
    remove_column :sellers, :name, :string
  end
end
