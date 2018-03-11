require 'rails_helper'
RSpec.describe MqttWorker, type: :worker do

  describe '#parse_message' do
    let(:sensor) { create(:sensor) }
    let(:device) { sensor.device }
    let(:alarm_service) { device.alarm_service }
    let(:msg) { {'gpio' => Sensor::PORT_GPIO[1]} }

    it 'runs AlarmService' do
      expect_any_instance_of(AlarmService).to receive(:handle_device_message).with(msg)
      MqttWorker.perform_async(:parse_message, topic: "#{device.number}/m", message: msg.to_json)
    end
  end
end
