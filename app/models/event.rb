class Event < ApplicationRecord
  belongs_to :sensor, inverse_of: :events
  belongs_to :object, class_name: 'GuardedObject', inverse_of: :events

  enum object_status: GuardedObject::STATUSES, _suffix: true
  enum sensor_status: Sensor::STATUSES, _suffix: true

  before_create :set_values
  after_create :send_notification

  scope :mobile_list, ->{ includes(:sensor).order(id: :desc).limit(50) }

  private

  def set_values
    self.object = sensor.device.object unless object
    self.sensor_status = sensor.status unless sensor_status
    self.object_status = object.status unless object_status
  end

  def send_notification
    GuardedObjectChannel.broadcast_to(self.object_id, {
      e: :event_added,
      html: ApplicationController.new.render_to_string(partial: 'mobile/guarded_objects/event', object: self)
    })
  end
end
