# Publish example
MQTT::Client.connect('mqtt://test:test@localhost') do |c|
  msg = {
    method: "OTA.Update",
    args: {
      section: "firmware",
      commit_timeout: 300,
      url: "http://172.16.10.171/fw.zip"
    },
    src: 'admin/result'
  }
  c.publish('test/rpc', msg.to_json)
end

msg = {
  method: 'Config.Set',
  args: {
    config: {
      device: {
        gpio_listen: 0,
        gpio_pull: 0
      }
    }
  },
  src: :rpc_result
}


# Subscribe example
MQTT::Client.connect('mqtt://test:test@localhost') do |c|
  # If you pass a block to the get method, then it will loop
  c.get('/test') do |topic,message|
    puts "#{topic}: #{message}"
  end
end

msg = {
  method: "OTA.Update",
  args: {
    section: "firmware",
    commit_timeout: 300,
    src: 'admin/result',
    url: "http://172.16.10.171:3000/fw.zip"
  }
}

mos call OTA.Update '{"section": "firmware","commit_timeout": 300,"blob_url": "http://172.16.10.171/fw.zip"}'

# cd /usr/local/Cellar/mosquitto/1.4.11_2/etc/mosquitto/
# sudo find / -name "pg_config" -print
# design
# https://medialoot.com/blog/10-most-promising-free-bootstrap-4-templates-for-2017/
