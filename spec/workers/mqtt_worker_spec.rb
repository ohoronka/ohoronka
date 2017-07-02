require 'rails_helper'
RSpec.describe MqttWorker, type: :worker do
  describe '#parse_message' do
    context 'ping' do
      let(:object) { create(:guarded_object, status: :protected)}
      let(:device) { create(:device, object: object, status: :online) }
      let!(:sensor) { create(:sensor, device: device, gpio_listen: 0b01, gpio_ok: 0b00, status: :ok) }

      it 'alarms' do
        # expect_any_instance_of(GuardedObject).to receive(:alarm!)
        expect{
          MqttWorker.perform_async(:parse_message, topic: "#{device.id}/m", message: {gpio: 0b01}.to_json)
          object.reload
          device.reload
          sensor.reload
        }.to change(object, :status).from('protected').to('alarm').
          and change(sensor, :status).from('ok').to('alarm').
          and change(Event, :count).from(0).to(1)
        event = sensor.events.take
        expect(event).to have_attributes({
          object_id: object.id,
          sensor_id: sensor.id,
          sensor_status: 'alarm',
          object_status: 'alarm'
        })
      end
    end
  end
end
