class FacilityShare < ApplicationRecord
  belongs_to :user
  belongs_to :facility
end
