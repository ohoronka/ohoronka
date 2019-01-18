# == Schema Information
#
# Table name: sensors
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  device_id   :uuid             not null
#  name        :string
#  status      :integer          default("offline"), not null
#  gpio_listen :integer          default(0), not null
#  gpio_ok     :integer          default(0), not null
#

FactoryBot.define do
  factory :sensor do
    association :device

    sequence(:name) {|n| "Sensor ##{n}"}
    gpio_listen { Sensor::PORT_GPIO[1] }
    gpio_ok { Sensor::PORT_GPIO[1] }
  end
end
