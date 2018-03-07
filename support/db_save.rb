File.open('db_struct.json', 'w') do |f|
  f.write(Facility.all.to_json(include: {devices: {include: [:sensors, mqtt_user: {include: :acls}]}, shares: {include: {user: {include: :channels}}}}))
end

db_struct = JSON.parse(File.read('db_struct.json'))
db_struct.each do |facility_data|
  facility_attr = facility_data.except('id', 'devices', 'shares')
  facility = Facility.create(facility_attr)
  facility_data['devices'].each do |device_data|
    device_attr = device_data.except('id', 'sensors')
  end
end

