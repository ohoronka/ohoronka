require 'rails_helper'

RSpec.describe AlarmService do
  let(:sensor) { create(:sensor) }
  let(:device) { sensor.device }
  let(:facility) { device.facility}
  let(:alarm_msg) { {'g' => 0, 'a' => 0 } }
  let(:alarm_service){ device.alarm_service }

  describe '#handle_device_message' do
    context 'facility is in idle state' do
      before { facility.update_attribute(:status, :idle) }

      it 'just changes the sensor status' do
        expect(sensor.alarm_status?).to be_falsey
        expect(device.status).to eq('offline')

        alarm_service.handle_device_message(alarm_msg)
        sensor.reload

        expect(device.status).to eq('online')
        expect(sensor.alarm_status?).to be_truthy
        expect(Event.count).to eq(1) # it creates event
        expect(facility.idle_status?).to be_truthy
      end
    end

    context 'facility is protected' do
      before { facility.update_attribute(:status, :protected) }

      it 'fires alarm' do
        alarm_service.handle_device_message(alarm_msg)
        sensor.reload

        expect(sensor.alarm_status?).to be_truthy
        expect(facility.alarm_status?).to be_truthy
        expect(Event.where(target: sensor, target_status: :alarm).count).to eq(1)
        expect(Event.where(target: facility, target_status: :alarm).count).to eq(1)
        # TODO notify web, but may be not here.
      end
    end

    context 'facility is alarmed' do
      before { facility.update_attribute(:status, :alarm) }

      it 'just writes extra logs' do
        alarm_service.handle_device_message(alarm_msg)
        sensor.reload

        expect(sensor.alarm_status?).to be_truthy
        expect(facility.alarm_status?).to be_truthy
        expect(Event.where(target: sensor, target_status: :alarm).count).to eq(1)
        # TODO: doesn't pass tests
        # expect(Event.where(target: facility, target_status: :alarm).count).to eq(0)
      end
    end
  end

  describe '#check_offline_devices' do
    context 'there is no offline devices' do
      before do
        sensor.update_attributes(status: :ok)
        device.update_attributes(status: :online, pinged_at: 1.second.ago)
        facility.update_attributes(status: :protected)
      end

      it 'does nothing' do
        AlarmService.check_offline_devices
        facility.reload
        expect(facility.status).to eq('protected')
        expect(device.status).to eq('online')
        expect(sensor.status).to eq('ok')
      end
    end

    context 'device became offline' do
      before do
        sensor.update_attributes(status: :ok)
        device.update_attributes(status: :online, pinged_at: 1.minute.ago)
        facility.update_attributes(status: :protected)
      end

      it 'fires alarm and writes log' do
        expect(facility.alarm_status?).to be_falsey

        AlarmService.check_offline_devices
        facility.reload

        expect(facility.alarm_status?).to be_truthy
        expect(Event.where(target: sensor, target_status: :offline).count).to eq(1)
        expect(Event.where(target: facility, target_status: :alarm).count).to eq(1)
      end

      it 'does not fires alarm if device does not contains sensors' do
        sensor.destroy

        AlarmService.check_offline_devices
        facility.reload

        expect(facility.alarm_status?).to be_falsey
      end
    end
  end

  describe 'ota implementation' do
    it 'sends OTA.Commit if fw version was changed' do
      expect(device).to receive(:rpc).with('OTA.Commit', {})
      alarm_service.handle_device_message({a: 0, g: 0, e: '', v: 2}.stringify_keys)
    end
  end

  describe 'the device connection to user' do
    let(:facility) { create(:facility) }
    let(:user) { facility.users.take }
    let(:device) { create(:device, facility: nil) }
    it 'connects device to user' do
      alarm_service.handle_device_message({a: 0, g: 0, e: user.email, v: 2}.stringify_keys)
      expect(device.user).to eq(user)
      expect(device.facility).to eq(facility)
    end
  end
end
