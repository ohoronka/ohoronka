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

require 'rails_helper'

RSpec.describe Sensor, type: :model do
  describe '#gpio_ok?' do
    let(:sensor) { build(:sensor) }

    it 'returns true' do
      expect(sensor.gpio_ok?(Sensor::PORT_GPIO[1])).to be_truthy
    end

    it 'returns false' do
      expect(sensor.gpio_ok?(0)).to be_falsey
    end
  end
end
