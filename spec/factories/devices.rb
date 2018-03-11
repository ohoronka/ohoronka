# == Schema Information
#
# Table name: devices
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  pinged_at   :datetime
#  number      :integer          not null
#  facility_id :uuid             not null
#  name        :string
#  status      :integer          default("offline"), not null
#  gpio_listen :integer          default(0), not null
#

FactoryBot.define do
  factory :device do
    association :facility, factory: :facility

    sequence(:name) {|n| "device ##{n}"}
  end
end
