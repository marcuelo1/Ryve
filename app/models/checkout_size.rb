class CheckoutSize < ApplicationRecord
  belongs_to :size
  belongs_to :checkout_product
end
