class Device < ApplicationRecord
  GPIO = [:gpio_listen, :gpio_pull, :gpio_ok]

  enum status: Facility::ALL_STATUSES.slice(:online, :offline), _suffix: true

  has_many :sensors, inverse_of: :device, dependent: :destroy
  belongs_to :facility, inverse_of: :devices

  validates :name, presence: true

  after_touch :update_gpio

  def ping!(gpio)
    self.pinged_at = Time.current
    self.status = :online

    if ((gpio & gpio_listen) ^ gpio_ok) != 0
      o = facility
      o.alarm!
    end
    sensors.each {|sensor| sensor.check_gpio!(gpio)}
    save!
  end

  def offline!
    offline_status!
    facility.alarm!
    sensors.update_all(status: :offline)
  end

  def rpc_config_set
    msg_config_set = {
      method: 'Config.Set',
      args: {
        config: {
          device: {
            gpio_listen: self.gpio_listen,
            gpio_pull: self.gpio_pull
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
    MQTT::Client.connect('mqtt://test:test@localhost') do |c|
      c.publish("#{self.id}/rpc", msg_config_set.to_json)
      sleep 0.5
      c.publish("#{self.id}/rpc", msg_config_save.to_json)
    end
  end

  def password_hash(password, salt: nil, iterations: 901)
    salt ||= SecureRandom.base64(12)
    password_hash = Base64.encode64(PBKDF2.new(password: password, salt: salt, iterations: iterations).bin_string)[0..31]
    "PBKDF2$sha256$#{iterations}$#{salt}$#{password_hash}"
  end

  private

  def update_gpio
    sensors.reload
    GPIO.each do |gpio|
      self.send("#{gpio}=".to_sym, sensors.map(&gpio).inject(&:|) || 0)
    end
    save!
  end
end
