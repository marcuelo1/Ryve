class CheckoutOrder < ApplicationRecord
    has_many :checkout_products, dependent: :destroy
end
