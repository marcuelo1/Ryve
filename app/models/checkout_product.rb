class CheckoutProduct < ApplicationRecord
  belongs_to :product
  belongs_to :checkout_order

  has_one :checkout_size, dependent: :destroy
  has_many :checkout_additionals, dependent: :destroy
end
