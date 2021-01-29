class WaterCurrTransaction < ApplicationRecord
  belongs_to :buyer
  belongs_to :rider
  belongs_to :water_provider
end
