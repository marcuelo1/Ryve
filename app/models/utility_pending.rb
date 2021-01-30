class UtilityPending < ApplicationRecord
  belongs_to :buyer
  belongs_to :provider, polymorphic: true
end
