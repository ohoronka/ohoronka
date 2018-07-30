require 'rails_helper'

# temporary spec to visit almost all pages and got exceptions in case of problems. It doesn't checks buttons and links
RSpec.feature "Navigations", type: :feature do
  describe 'navigation over the system' do
    context 'as normal user' do
      let(:user) { create(:user) }

      before do
        login_as(user.email, 'password')
      end

      it 'navigates over the site' do
        sensor = create(:sensor)
        device = sensor.device
        facility = device.facility

        visit facilities_path
        visit new_facility_path
        visit facility_path(facility)
        visit edit_facility_path(facility)


        visit facility_devices_path(facility)
        visit edit_facility_device_path(facility, device)

        visit facility_sensors_path(facility)
        visit new_facility_sensor_path(facility)
        visit edit_facility_sensor_path(facility, sensor)

        visit facility_events_path(facility)

        visit notifications_path

        visit channels_path
        visit new_channel_path(type: 'Telegram')
        visit select_type_channels_path
        visit edit_user_path(user)

        visit facility_facility_shares_path(facility)

        visit devices_path
        visit edit_device_path(device)
      end
    end
  end
end
