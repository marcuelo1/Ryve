class CurrentTransaction < ApplicationRecord
  belongs_to :buyer
  belongs_to :seller
  belongs_to :rider
  belongs_to :buyer_location

  def checkout_products
    CheckoutOrder.find(self.checkout_order_id).checkout_products
  end
  
end
