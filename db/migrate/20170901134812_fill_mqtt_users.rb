class FillMqttUsers < ActiveRecord::Migration[5.1]
  def up
    Device.includes(:mqtt_user).find_each do |device|
      device.send(:set_mqtt_user) unless device.mqtt_user.present?
    end

    unless Mqtt::User.find_by(user_name: Mqtt.user_name)
      listener = Mqtt::User.create(user_name: Mqtt.user_name, password: Mqtt.password)
      listener.acls.destroy_all
      listener.acls.create(topic: '#', rw: :full)
    end
  end

  def down

  end
end
