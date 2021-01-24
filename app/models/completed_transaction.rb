class CompletedTransaction < ApplicationRecord
  belongs_to :rider
  belongs_to :product
  belongs_to :buyer
  belongs_to :buyer_location
end
