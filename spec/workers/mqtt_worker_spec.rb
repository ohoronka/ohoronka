require 'rails_helper'
RSpec.describe MqttWorker, type: :worker do
  describe '#parse_message' do
    context 'ping' do
      let(:device) { create(:device) }
      let!(:sensor) { create(:sensor, device: device, gpio_listen: 0b01, gpio_ok: 0b00) }

      it 'alarms' do
        expect_any_instance_of(GuardObject).to receive(:alarm!)
        MqttWorker.perform_async(:parse_message, topic: device.id.to_s, message: {gpio: 0b01}.to_json)
      end
    end
  end
end
