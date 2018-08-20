MQTT::Client.connect("mqtt://#{Mqtt.user_name}:#{Mqtt.password}@#{Mqtt.host}") do |c|
  c.get('#') do |topic,message|
    puts "#{topic}: #{message}"
    # MqttWorker.perform_async(:parse_message, topic: topic, message: message)
  end
end
