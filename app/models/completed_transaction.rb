class CompletedTransaction < ApplicationRecord
  before_destroy :destroy_checkout_order
  
  belongs_to :rider
  belongs_to :seller
  belongs_to :buyer
  belongs_to :buyer_location

  def checkout_products
    CheckoutOrder.find(self.checkout_order_id).checkout_products
  end

  def destroy_checkout_order
    CheckoutOrder.find(self.checkout_order_id).destroy
  end
end
