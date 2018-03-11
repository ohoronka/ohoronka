db_struct = JSON.parse(File.read('db_struct.json'))
ActiveRecord::Base.transaction do
  db_struct['users'].each do |user_data|
    user_attr = user_data.except('id', 'channels', 'mobile_devices', 'about', 'background')
    user = User.new(user_attr)
    user.save(validate: false)
    user_data['channels'].each do |channel_data|
      channel_attr = channel_data.except('id')
      channel_attr['active'] = channel_attr.delete('activated')
      user.channels.create(channel_attr)
    end

    user_data['mobile_devices'].each do |md_data|
      md_attr = md_data.except('id')
      user.mobile_devices.create(md_attr)
    end
  end

  db_struct['facilities'].each do |facility_data|
    facility_attr = facility_data.except('id', 'devices', 'shares')
    facility = Facility.create(facility_attr)
    facility_data['shares'].each do |share_data|
      user_email = share_data['user_email']
      user = User.find_by(email: user_email)
      raise 'User was not found' if user.blank?
      share_attr = share_data.except('facility_id', 'user_id', 'user_email')
      share_attr[:user_id] = user.id
      facility.shares.create(share_attr)
    end

    facility_data['devices'].each do |device_data|
      device_attr = device_data.except('id', 'sensors', 'gpio_pull', 'gpio_ok', 'mqtt_user')
      device_attr['number'] = device_data['id']
      device = facility.devices.create(device_attr)
      device.mqtt_user.update(password: device_data['mqtt_user']['password'])
      device_data['sensors'].each do |sensor_data|
        sensor_attr = sensor_data.except('id', 'gpio_pull')
        device.sensors.create(sensor_attr)
      end
    end
  end
end
