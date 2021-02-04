class Product < ApplicationRecord
  belongs_to :product_category

  has_many :current_transactions, dependent: :destroy
  has_many :completed_transactions, dependent: :destroy
  has_many :checkout_products, dependent: :destroy
  has_many :sizes, dependent: :destroy
  has_many :additionals, dependent: :destroy

  # Media
  has_one_attached :product_image
end
