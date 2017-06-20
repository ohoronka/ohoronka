class Event < ApplicationRecord
  belongs_to :sensor, inverse_of: :events
  belongs_to :object, class_name: 'GuardedObject', inverse_of: :events

  before_create :set_values

  private

  def set_values
    self.object = sensor.device.object unless object
    self.status = sensor.status unless status
    self.object_status = object.status unless object_status
  end
end
