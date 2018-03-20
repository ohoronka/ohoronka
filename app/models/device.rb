# == Schema Information
#
# Table name: devices
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  pinged_at   :datetime
#  number      :integer          not null
#  facility_id :uuid             not null
#  name        :string
#  status      :integer          default("offline"), not null
#  gpio_listen :integer          default(0), not null
#

class Device < ApplicationRecord
  GPIO = [:gpio_listen]

  enum status: ALL_STATUSES.slice(:online, :offline), _suffix: true

  has_many :sensors, inverse_of: :device, dependent: :destroy
  belongs_to :facility, inverse_of: :devices
  has_one :mqtt_user, :class_name => 'Mqtt::User', dependent: :destroy

  validates :name, presence: true

  after_touch :update_gpio
  after_create :set_mqtt_user

  def config_string
    # puts "mos wifi AP 0509435618" if Rails.env.development?
    server = Rails.env.development? ? "192.168.0.103:1883" : "ohoronka.com:1883"
    puts "mos config-set mqtt.server=#{server} mqtt.client_id=#{id} mqtt.user=#{mqtt_user.user_name} mqtt.pass=#{mqtt_user.password} device.id=#{id} device.gpio_listen=#{Sensor::PORT_GPIO.values.inject(0){|sum, port| sum | port}} wifi.ap.ssid=OHORONKA#{id} wifi.ap.pass=12345678"
    puts "mos wifi TP-LINK_3B3DC8 0505933918"
  end

  def rpc_config_set
    msg_config_set = {
      method: 'Config.Set',
      args: {
        config: {
          device: {
            id: self.id.to_s,
            gpio_listen: self.gpio_listen,
          },
          mqtt: {
            client_id: self.id.to_s,
            user: self.mqtt_user.user_name,
            pass: self.mqtt_user.password
          }
        }
      },
      src: :rpc_result
    }

    msg_config_save = {
      method: 'Config.Save',
      args: {
        reboot: true
      },
      src: :rpc_result
    }
    # TODO make general mqtt sender or RPC model/service
    Mqtt.as_admin do |c|
      c.publish("#{self.id}/rpc", msg_config_set.to_json)
      sleep 0.5
      c.publish("#{self.id}/rpc", msg_config_save.to_json)
    end
  end

  def rpc(method, params)
    body = {
      method: method,
      args: params,
      src: :rpc_result
    }
    Mqtt.as_admin do |c|
      c.publish("#{self.number}/rpc", body.to_json)
    end
  end

  # it sets alarm sound on device
  def set_alarm(alarm = facility.alarm_status?)
    self.rpc('alarm', {enabled: (alarm ? 1 : 0)})
  end

  def alarm_service
    @alarm_service ||= AlarmService.new(device: self, facility: facility)
  end

  # number creates on DB side. So we need to reload the data
  def number
    reload if attributes['number'].nil? && persisted?
    attributes['number']
  end

  private

  def update_gpio
    sensors.reload
    self.gpio_listen = sensors.map(&:gpio_listen).inject(&:|) || 0
    save!
  end

  def set_mqtt_user
    self.create_mqtt_user(user_name: self.number)
  end
end
