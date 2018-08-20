while true do
  puts "Take the label and enter it's number"
  input = gets.chomp
  break if input == 'exit'
  number = input.to_i
  device = Device.find_by(number: number)
  device.send_config 2
  while true do
    puts "Configuring..."
    sleep 2
    device.reload
    break if device.online_status?
  end
  puts "The device has been configured"

  device.update_firmware

  while true do
    puts "Updating..."
    sleep 2
    device.reload
    break if device.fw_version > 0
  end

  puts "The device has been updated. Connect the next one."
end
