require 'sidekiq'
require_relative 'app/workers/mqtt_worker'
require 'erb'
require 'yaml'
require 'mqtt'

env = ENV["RAILS_ENV"] || ENV["RACK_ENV"] || "development"

redis_config = (YAML.load(ERB.new(File.read("config/redis.yml")).result) || {})[env] || {}
mqtt_config = (YAML.load(ERB.new(File.read("config/mqtt.yml")).result) || {})[env] || {}

Sidekiq.configure_client do |config|
  config.redis = redis_config['sidekiq']
end


begin
  pid_file = File.expand_path('tmp/pids/mqtt_listener.pid', Dir.pwd)
  File.open(pid_file, "w") do |f|
    f.write Process.pid
  end

  MQTT::Client.connect("mqtt://#{mqtt_config['user_name']}:#{mqtt_config['password']}@#{mqtt_config['host']}") do |c|
    c.get('#') do |topic,message|
      # puts "#{topic}: #{message}"
      MqttWorker.perform_async(:parse_message, topic: topic, message: message)
    end
  end
ensure
  File.delete(pid_file) if File.exists?(pid_file)
end
