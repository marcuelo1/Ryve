class ElecCurrTransaction < ApplicationRecord
  belongs_to :buyer
  belongs_to :rider
  belongs_to :electricity_provider
end
