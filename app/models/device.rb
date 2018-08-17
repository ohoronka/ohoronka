# == Schema Information
#
# Table name: devices
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  pinged_at   :datetime
#  number      :integer          not null
#  facility_id :uuid
#  name        :string
#  status      :integer          default("offline"), not null
#  gpio_listen :integer          default(0), not null
#  fw_version  :integer          default(0)
#  user_id     :uuid
#

class Device < ApplicationRecord
  GPIO = [:gpio_listen]

  enum status: ALL_STATUSES.slice(:online, :offline), _suffix: true

  has_many :sensors, inverse_of: :device, dependent: :destroy
  belongs_to :facility, inverse_of: :devices, optional: true
  belongs_to :user, optional: true, inverse_of: :devices
  has_one :mqtt_user, :class_name => 'Mqtt::User', dependent: :destroy

  scope :free, -> { where(user_id: nil) }

  validates :name, presence: true

  after_create :set_mqtt_user
  before_create :set_options

  def send_config(to_number = self.number)
    msg_config_set = {
      method: 'Config.Set',
      args: {
        config: {
          device: {
            id: number.to_s,
          },
          mqtt: {
            server: 'ohoronka.com:8883',
            ssl_ca_cert: 'ca.pem',
            client_id: number.to_s,
            user: mqtt_user.user_name,
            pass: mqtt_user.password
          },
          wifi: {
            ap: {
              ssid: self.decorate.wifi_ap,
              pass: self.decorate.wifi_password
            },
            sta: {
              nameserver: '18.194.211.108'
            }
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

    Mqtt.as_admin do |c|
      c.publish("#{to_number}/rpc", msg_config_set.to_json)
      sleep 2
      c.publish("#{to_number}/rpc", msg_config_save.to_json)
    end
  end

  def update_firmware(url = 'http://mongoose-os.com/fw.zip', commit_timeout: 300)
    msg_update = {
      method: 'OTA.Update',
      args: {
        url: url,
        commit_timeout: commit_timeout
      },
      src: :rpc_result
    }

    Mqtt.as_admin do |c|
      c.publish("#{number}/rpc", msg_update.to_json)
    end
  end

  # it sets alarm sound on device
  def set_alarm(alarm = facility.alarm_status?)
    rpc('alarm', {enabled: (alarm ? 1 : 0)})
  end

  def alarm_service
    @alarm_service ||= AlarmService.new(device: self, facility: facility)
  end

  # number creates on DB side. So we need to reload the data
  def number
    reload if attributes['number'].nil? && persisted?
    attributes['number']
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

  private

  def set_options
    self.options['wifi_password'] = rand 100_000_000
  end

  def set_mqtt_user
    self.create_mqtt_user(user_name: self.number)
  end
end
