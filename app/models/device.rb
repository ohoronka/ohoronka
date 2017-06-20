class Device < ApplicationRecord
  GPIO = [:gpio_listen, :gpio_pull, :gpio_ok]

  enum status: GuardedObject::ALL_STATUSES.slice(:online, :offline), _suffix: true

  has_many :sensors, inverse_of: :device, dependent: :destroy
  belongs_to :object, class_name: 'GuardedObject', foreign_key: :object_id, inverse_of: :devices

  after_touch :update_gpio

  def ping!(gpio)
    # update(pinged_at: Time.current)
    # TODO implement alarm
    object.alarm! if ((gpio & gpio_listen) ^ gpio_ok) != 0
  end

  private

  def update_gpio
    sensors.reload
    GPIO.each do |gpio|
      self.send("#{gpio}=".to_sym, sensors.map(&gpio).inject(&:|))
    end
    save!
  end
end
