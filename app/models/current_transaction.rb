class CurrentTransaction < ApplicationRecord
  belongs_to :buyer
  belongs_to :seller
  belongs_to :rider
end
