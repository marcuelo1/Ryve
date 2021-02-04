class RemovePriceAndDiscountFromProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :price, :integer
    remove_column :products, :discount, :integer
  end
end
