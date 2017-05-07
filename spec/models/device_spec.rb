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
end
