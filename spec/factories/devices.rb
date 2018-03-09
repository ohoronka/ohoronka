# == Schema Information
#
# Table name: devices
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  pinged_at   :datetime
#  facility_id :integer
#  name        :string
#  status      :integer          default("offline"), not null
#  gpio_listen :integer          default(0), not null
#  gpio_pull   :integer          default(0), not null
#  gpio_ok     :integer          default(0), not null
#

FactoryBot.define do
  factory :device do
    association :facility, factory: :facility

    sequence(:name) {|n| "device ##{n}"}
  end
end
