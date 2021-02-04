class BuyerLocation < ApplicationRecord
  belongs_to :buyer

  # geocdoe
  geocoded_by :location
  after_validation :geocode, if: :location_changed?
end
