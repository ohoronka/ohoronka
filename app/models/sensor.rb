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
    events.create(facility: device.facility) if status_changed?
    FacilityChannel.broadcast_to(self.device.facility_id, {
      e: :sensor_updated,
      id: self.id,
      html: ApplicationController.new.render_to_string(partial: 'mobile/facilities/sensor', object: self)
    })
  end
end
