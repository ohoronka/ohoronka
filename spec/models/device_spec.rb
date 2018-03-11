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

require 'rails_helper'

RSpec.describe Device, type: :model do
  let(:device) { create(:device) }

  it 'creates device' do
    device = create(:device)
    expect(device.number).not_to be_nil
  end

  describe '#update_gpio' do
    before do
      [0b01, 0b10].each do |gpio|
        create(:sensor, device: device, gpio_listen: gpio, gpio_ok: gpio)
      end
    end

    it 'updates device gpio state' do
      Device::GPIO.each do |gpio|
        expect(device.send(gpio)).to eq(0b11)
      end
    end
  end

  # TODO: moved to MQTT module
  # describe '#password_hash' do
  #   it 'generates hash' do
  #     expect(Device.new.password_hash('password', salt: 'cTiaovSH5BgWlU7m')).to eq('PBKDF2$sha256$901$cTiaovSH5BgWlU7m$Iq1z7pg0sl92aGhLI6cMyv3+0iPcRNro')
  #   end
  # end
end
