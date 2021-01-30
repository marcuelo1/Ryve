class UtilityCurrent < ApplicationRecord
  belongs_to :buyer
  belongs_to :rider
  belongs_to :provider, polymorphic: true
end
