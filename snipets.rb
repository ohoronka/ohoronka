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

c = MQTT::Client.connect('mqtt://2:b1Vg3ze0ESDqlRi571C7nyUw8nMQ24tjlznvJApj@ohoronka.com')

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

# nove posta api ea4e107522c7cedd8985edd0ea5b485f

# iptables -t nat -L -v -n
# iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE
# iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 3000 -j DNAT --to-destination 10.8.0.6:3000

# {"signature"=>"V+hV4Z8ZYBj3BN83kaBXxpOYXi8=", "data"=>"eyJhY3Rpb24iOiJwYXkiLCJwYXltZW50X2lkIjo2MDM4NzM3OTgsInN0YXR1cyI6IndhaXRfYWNjZXB0IiwidmVyc2lvbiI6MywidHlwZSI6ImJ1eSIsInBheXR5cGUiOiJvbmVjbGljayIsInB1YmxpY19rZXkiOiJpNjE5MDc2MzIyNzYiLCJhY3FfaWQiOjQxNDk2Mywib3JkZXJfaWQiOiIzIiwibGlxcGF5X29yZGVyX2lkIjoiTTVBWVBCVEgxNTE2NTcyMTcxNjAxMjAwIiwiZGVzY3JpcHRpb24iOiLQntC/0LvQsNGC0LAg0L7QsdC70LDQtNC90LDQvdC90Y8iLCJzZW5kZXJfcGhvbmUiOiIzODA2NjExNjc2OTciLCJzZW5kZXJfZmlyc3RfbmFtZSI6ItCR0L7Qs9C00LDQvSIsInNlbmRlcl9sYXN0X25hbWUiOiLQk9GD0LHQsNC90YwiLCJzZW5kZXJfY2FyZF9tYXNrMiI6IjUxNjkzMyoxMCIsInNlbmRlcl9jYXJkX2JhbmsiOiJwYiIsInNlbmRlcl9jYXJkX3R5cGUiOiJtYyIsInNlbmRlcl9jYXJkX2NvdW50cnkiOjgwNCwiYW1vdW50IjoxLjAsImN1cnJlbmN5IjoiVUFIIiwic2VuZGVyX2NvbW1pc3Npb24iOjAuMCwicmVjZWl2ZXJfY29tbWlzc2lvbiI6MC4wMywiYWdlbnRfY29tbWlzc2lvbiI6MC4wLCJhbW91bnRfZGViaXQiOjEuMCwiYW1vdW50X2NyZWRpdCI6MS4wLCJjb21taXNzaW9uX2RlYml0IjowLjAsImNvbW1pc3Npb25fY3JlZGl0IjowLjAzLCJjdXJyZW5jeV9kZWJpdCI6IlVBSCIsImN1cnJlbmN5X2NyZWRpdCI6IlVBSCIsInNlbmRlcl9ib251cyI6MC4wLCJhbW91bnRfYm9udXMiOjAuMCwiYXV0aGNvZGVfZGViaXQiOiIyMzY1NDkiLCJycm5fZGViaXQiOiIwMDA3ODYwMDA1NjQiLCJtcGlfZWNpIjoiNyIsImlzXzNkcyI6ZmFsc2UsImNyZWF0ZV9kYXRlIjoxNTE2NTcyMTcxNTk5LCJ0cmFuc2FjdGlvbl9pZCI6NjAzODczNzk4fQ==", "order_id"=>"3"}
