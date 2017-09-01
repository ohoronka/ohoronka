class FillMqttUsers < ActiveRecord::Migration[5.1]
  def up
    Device.includes(:mqtt_user).find_each do |device|
      device.send(:set_mqtt_user) unless device.mqtt_user.present?
    end

    unless Mqtt::User.find_by(user_name: 'mqtt_listener')
      listener = Mqtt::User.create(user_name: 'mqtt_listener')
      listener.acls.destroy_all
      listener.acls.create(topic: '#', rw: :full)
    end
  end

  def down

  end
end
