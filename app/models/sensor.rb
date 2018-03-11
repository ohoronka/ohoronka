# == Schema Information
#
# Table name: sensors
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  device_id   :uuid             not null
#  name        :string
#  status      :integer          default("offline"), not null
#  gpio_listen :integer          default(0), not null
#  gpio_ok     :integer          default(0), not null
#

class Sensor < ApplicationRecord
  STATUSES = ALL_STATUSES.slice(:alarm, :ok, :offline)
  PORT_GPIO = {1 => 16, 2 => 32, 3 => 4096, 4 => 8192}

  belongs_to :device, inverse_of: :sensors, touch: true
  has_many :events, as: :target, dependent: :delete_all, inverse_of: :target

  enum status: STATUSES, _suffix: true

  after_update :create_event
  after_update :notify_web

  def gpio_ok?(gpio)
    ((gpio & gpio_listen) ^ gpio_ok) == 0
  end

  def gpio_alarm?(gpio)
    !gpio_ok?(gpio)
  end

  private

  def create_event
    return unless saved_changes.key?(:status)
    events.create(facility: device.facility)
  end

  def notify_web
    FacilityChannel.broadcast_to(self.device.facility_id, {
      e: :sensor_updated,
      sensor: {
        id: id,
        name: name,
        status: status,
        t_status: decorate.status,
        css_status: decorate.css_status
      }
    })
  end
end
