require 'rails_helper'
RSpec.describe MqttWorker, type: :worker do
  describe '#parse_message' do
    context 'ping' do
      let(:facility) { create(:facility, status: :protected)}
      let(:device) { create(:device, facility: facility, status: :online) }
      let!(:sensor) { create(:sensor, device: device, gpio_listen: 0b01, gpio_ok: 0b00, status: :ok) }

      it 'alarms' do
        # expect_any_instance_of(Facility).to receive(:alarm!)
        expect{
          MqttWorker.perform_async(:parse_message, topic: "#{device.id}/m", message: {gpio: 0b01}.to_json)
          facility.reload
          device.reload
          sensor.reload
        }.to change(facility, :status).from('protected').to('alarm').
          and change(sensor, :status).from('ok').to('alarm').
          and change(Event, :count).from(0).to(1)
        event = sensor.events.take
        expect(event).to have_attributes({
          facility_id: facility.id,
          sensor_id: sensor.id,
          sensor_status: 'alarm',
          facility_status: 'alarm'
        })
      end
    end
  end
end
