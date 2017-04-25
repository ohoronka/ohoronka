# TODO use configuration to pass server credentials
MQTT::Client.connect('mqtt://test:test@localhost') do |c|
  c.get('#') do |topic,message|
    puts "#{topic}: #{message}"
    MqttWorker.perform_async(:parse_message, topic: topic, message: message)
  end
end
