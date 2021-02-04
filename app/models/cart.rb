class Cart < ApplicationRecord
  belongs_to :buyer
  belongs_to :seller

  def checkout_products
    CheckoutOrder.find(self.checkout_order_id).checkout_products
  end
end
