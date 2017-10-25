class AlarmService
  include ActiveModel::Model

  attr_accessor :device, :facility

  def handle_device_message(msg)
    # mark device as online
    device.pinged_at = Time.current
    device.status = :online

    gpio = msg['gpio']

    fire_alarm if device.sensors.any?{|sensor| sensor.gpio_alarm?(gpio)}

    device.sensors.each do |sensor|
      sensor.gpio_ok?(gpio) ? sensor.ok_status! : sensor.alarm_status!
    end

    device_alarm_status = (msg['alarm'] != 0) # 1: alarm; 0: normal; like in c++
    device.set_alarm if device_alarm_status != facility.alarm_status?
  end

  def fire_alarm
    if facility.protected_status?
      facility.alarm_status!
      facility.users.each do |user|
        user.channels.each do |channel|
          channel.notify_facility_alarm(facility)
        end
      end
    end
  end

  def disable_alarm(user:)
    facility.idle_status!
    facility.users.each do |user|
      user.channels.each do |channel|
        channel.notify_disabled_alarm(facility: facility)
      end
    end
  end

  def self.check_offline_devices
    # TODO caution! in case of crash on a large amount of devices, it can take a lot of time! So not all devices
    # can be marked as offline
    begin
      devices = Device.where(status: :online).where('pinged_at < ?', 30.seconds.ago).includes(:sensors, :facility).limit(500).each do |device|
        device.alarm_service.fire_alarm if device.sensors.to_a.any?
        device.offline_status!
        device.sensors.each(&:offline_status!)
      end
    end until devices.any?
  end

end