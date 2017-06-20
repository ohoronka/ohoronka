class Sensor < ApplicationRecord
  STATUSES = GuardedObject::ALL_STATUSES.slice(:alarm, :ok, :offline)

  belongs_to :device, inverse_of: :sensors, touch: true
  has_many :events, dependent: :delete_all, inverse_of: :sensor

  enum status: STATUSES, _suffix: true

  after_update :create_event

  def check_gpio!(gpio)
    ((gpio & gpio_listen) ^ gpio_ok) != 0 ? alarm_status! : ok_status!
  end

  private

  def create_event
    events.create(object: device.object)
  end
end
