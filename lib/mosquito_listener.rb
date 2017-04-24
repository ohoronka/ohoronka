# TODO use configuration to pass server credentials
MQTT::Client.connect('mqtt://test:test@localhost') do |c|
  c.get('#') do |topic,message|
    puts "#{topic}: #{message}"
    # TODO start job
  end
end
