class Product < ApplicationRecord
  belongs_to :product_category

  has_many :current_transactions, dependent: :destroy
  has_many :completed_transactions, dependent: :destroy
end
