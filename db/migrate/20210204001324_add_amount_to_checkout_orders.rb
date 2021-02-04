class AddAmountToCheckoutOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :checkout_orders, :amount, :integer, :default => 0
    #Ex:- :default =>''
  end
end
