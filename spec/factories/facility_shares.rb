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

FactoryBot.define do
  factory :facility_share do
    user nil
    facility nil
  end
end
