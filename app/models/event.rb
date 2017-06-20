class Event < ApplicationRecord
  belongs_to :sensor, inverse_of: :events
  belongs_to :object, class_name: 'GuardedObject', inverse_of: :events

  enum object_status: GuardedObject::STATUSES, _suffix: true
  enum sensor_status: Sensor::STATUSES, _suffix: true

  before_create :set_values

  private

  def set_values
    self.object = sensor.device.object unless object
    self.sensor_status = sensor.status unless sensor_status
    self.object_status = object.status unless object_status
  end
end
