require 'rails_helper'

RSpec.describe Device, type: :model do
  let(:device) { create(:device) }

  describe '#update_gpio' do
    before do
      [0b01, 0b10].each do |gpio|
        create(:sensor, device: device, gpio_listen: gpio, gpio_pull: gpio, gpio_ok: gpio)
      end
    end

    it 'updates device gpio state' do
      Device::GPIO.each do |gpio|
        expect(device.send(gpio)).to eq(0b11)
      end
    end
  end

  describe '#ping!' do
    let!(:sensor) { create(:sensor, device: device, gpio_listen: 0b01, gpio_ok: 0b00) }

    it 'alarms' do
      expect(device.facility).to receive(:alarm!)
      device.ping!(0b01)
    end

    it 'does not alarms' do
      expect(device.facility).not_to receive(:alarm!)
      device.ping!(0b00)
    end
  end
end
