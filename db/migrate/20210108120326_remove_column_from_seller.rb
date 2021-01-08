class RemoveColumnFromSeller < ActiveRecord::Migration[6.0]
  def change
    remove_column :sellers, :comapny_name, :string
  end
end
