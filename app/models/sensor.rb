class Sensor < ApplicationRecord
  STATUSES = Facility::ALL_STATUSES.slice(:alarm, :ok, :offline)

  belongs_to :device, inverse_of: :sensors, touch: true
  has_many :events, as: :target, dependent: :delete_all, inverse_of: :target

  enum status: STATUSES, _suffix: true

  after_update :create_event

  def check_gpio!(gpio)
    ((gpio & gpio_listen) ^ gpio_ok) != 0 ? alarm_status! : ok_status!
  end

  private

  def create_event
    if saved_changes.key?(:status)
      events.create(facility: device.facility)
      FacilityChannel.broadcast_to(self.device.facility_id, {
        e: :sensor_updated,
        sensor: {
          id: id,
          name: name,
          status: status,
          css_status: decorate.css_status
        }
      })
    end
  end
end
