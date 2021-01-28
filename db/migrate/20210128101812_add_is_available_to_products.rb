class AddIsAvailableToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :is_available, :boolean, default: true
  end
end
