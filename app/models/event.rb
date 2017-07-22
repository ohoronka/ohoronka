class Event < ApplicationRecord
  belongs_to :sensor, inverse_of: :events
  belongs_to :facility, class_name: 'Facility', inverse_of: :events

  enum facility_status: Facility::STATUSES, _suffix: true
  enum sensor_status: Sensor::STATUSES, _suffix: true

  before_create :set_values
  after_create :send_notification

  scope :mobile_list, ->{ includes(:sensor).order(id: :desc).limit(50) }

  private

  def set_values
    self.facility = sensor.device.facility unless facility
    self.sensor_status = sensor.status unless sensor_status
    self.facility_status = facility.status unless facility_status
  end

  def send_notification
    FacilityChannel.broadcast_to(self.facility_id, {
      e: :event_created,
      html: ApplicationController.new.render_to_string(partial: 'mobile/facilities/event', object: self)
    })
  end
end
