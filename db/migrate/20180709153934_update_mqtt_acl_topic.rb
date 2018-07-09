class UpdateMqttAclTopic < ActiveRecord::Migration[5.1]
  def up
    change_column_null(:mqtt_users, :device_id, true)

    Mqtt::Acl.includes(mqtt_user: :device).each do |acl|
      next if acl.mqtt_user.user_name == Mqtt.user_name
      acl.topic = "#{acl.mqtt_user.device.number}/#"
      acl.save
    end

    user = Mqtt::User.create(user_name: Mqtt.user_name, password: Mqtt.password)
    user.acls.create(topic: '#', rw: :full)
  end

  def down
    Mqtt::User.find_by(user_name: Mqtt.user_name).destroy

    Mqtt::Acl.includes(mqtt_user: :device).each do |acl|
      next if acl.mqtt_user.user_name == Mqtt.user_name
      acl.topic = "#{acl.mqtt_user.device_id}/#"
      acl.save
    end

    change_column_null(:mqtt_users, :device_id, false)
  end
end
