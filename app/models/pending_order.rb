class PendingOrder < ApplicationRecord
  belongs_to :buyer
  belongs_to :seller
  belongs_to :buyer_location
end
