users = User.all.map do |user|
  user_attr = user.attributes
  user_attr['channels'] = user.channels.map(&:attributes)
  user_attr['mobile_devices'] = user.mobile_devices.map(&:attributes)
  user_attr
end

facilities = Facility.all.map do |facility|
  facility_attr = facility.attributes
  facility_attr['devices'] = facility.devices.includes(:sensors, :mqtt_user).all.map do |device|
    device_attr = device.attributes
    device_attr['sensors'] = device.sensors.all.map(&:attributes)
    device_attr['mqtt_user'] = device.mqtt_user.attributes
    device_attr
  end
  facility_attr['shares'] = facility.shares.includes(:user).all.map do |share|
    share_attr = share.attributes
    share_attr[:user_email] = share.user.email
    share_attr
  end
  facility_attr
end

File.open('db_struct.json', 'w') do |f|
  data = {
    facilities: facilities,
    users: users
  }
  f.write(data.to_json)
end
