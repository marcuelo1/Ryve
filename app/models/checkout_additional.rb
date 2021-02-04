class CheckoutAdditional < ApplicationRecord
  belongs_to :additional
  belongs_to :checkout_product
end
