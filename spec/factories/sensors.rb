# == Schema Information
#
# Table name: sensors
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  device_id   :integer
#  name        :string(255)
#  status      :integer          default("offline"), not null
#  gpio_listen :integer          default(0), not null
#  gpio_pull   :integer          default(0), not null
#  gpio_ok     :integer          default(0), not null
#

FactoryGirl.define do
  factory :sensor do
    association :device

    sequence(:name) {|n| "Sensor ##{n}"}
  end
end
