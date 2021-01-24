class CurrentTransaction < ApplicationRecord
  belongs_to :buyer
  belongs_to :product
  belongs_to :rider
  belongs_to :buyer_location
end
