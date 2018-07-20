begin
  pid_file = File.expand_path('tmp/pids/mqtt_listener.pid', Rails.root)
  File.open(pid_file, "w") do |f|
    f.write Process.pid
  end

  MQTT::Client.connect("mqtt://#{Mqtt.user_name}:#{Mqtt.password}@#{Mqtt.host}") do |c|
    c.get('#') do |topic,message|
      # puts "#{topic}: #{message}"
      MqttWorker.perform_async(:parse_message, topic: topic, message: message)
    end
  end
ensure
  File.delete(pid_file) if File.exists?(pid_file)
end
