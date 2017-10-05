# == Schema Information
#
# Table name: facility_shares
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  facility_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  role        :integer          default("owner")
#

class FacilityShare < ApplicationRecord
  ROLES = {
    owner: 0,
    guard: 1
  }

  belongs_to :user
  belongs_to :facility

  enum role: ROLES
end
