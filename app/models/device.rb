# == Schema Information
#
# Table name: devices
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  pinged_at   :datetime
#  facility_id :integer
#  name        :string(255)
#  status      :integer          default("offline"), not null
#  gpio_listen :integer          default(0), not null
#  gpio_pull   :integer          default(0), not null
#  gpio_ok     :integer          default(0), not null
#

class Device < ApplicationRecord
  GPIO = [:gpio_listen, :gpio_pull, :gpio_ok]

  enum status: ALL_STATUSES.slice(:online, :offline), _suffix: true

  has_many :sensors, inverse_of: :device, dependent: :destroy
  belongs_to :facility, inverse_of: :devices
  has_one :mqtt_user, :class_name => 'Mqtt::User', dependent: :destroy

  validates :name, presence: true

  after_touch :update_gpio
  after_create :set_mqtt_user

  def rpc_config_set
    msg_config_set = {
      method: 'Config.Set',
      args: {
        config: {
          device: {
            id: self.id.to_s,
            gpio_listen: self.gpio_listen,
            gpio_pull: self.gpio_pull
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
      c.publish("#{self.id}/rpc", body.to_json)
    end
  end

  # it sets alarm sound on device
  def set_alarm(alarm = facility.alarm_status?)
    self.rpc('alarm', {enabled: (alarm ? 1 : 0)})
  end

  def alarm_service
    @alarm_service ||= AlarmService.new(device: self, facility: facility)
  end

  private

  def update_gpio
    sensors.reload
    GPIO.each do |gpio|
      self.send("#{gpio}=".to_sym, sensors.map(&gpio).inject(&:|) || 0)
    end
    save!
  end

  def set_mqtt_user
    self.create_mqtt_user(user_name: self.id)
  end
end
