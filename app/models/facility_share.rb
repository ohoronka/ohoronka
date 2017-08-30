class FacilityShare < ApplicationRecord
  ROLES = {
    owner: 0,
    guard: 1
  }

  belongs_to :user
  belongs_to :facility

  enum role: ROLES
end
