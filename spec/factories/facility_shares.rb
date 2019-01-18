# == Schema Information
#
# Table name: facility_shares
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :uuid             not null
#  facility_id :uuid             not null
#  role        :integer          default("owner")
#

FactoryBot.define do
  factory :facility_share do
    user { nil }
    facility { nil }
  end
end
