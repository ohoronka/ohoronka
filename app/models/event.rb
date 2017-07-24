class Event < ApplicationRecord
  belongs_to :target, polymorphic: true, inverse_of: :events
  belongs_to :facility, inverse_of: :events

  enum facility_status: Facility::STATUSES, _suffix: true
  enum target_status: Sensor::STATUSES, _suffix: true

  before_validation :set_values, on: [:create]
  after_create :send_notification

  scope :mobile_list, ->{ includes(:target).order(id: :desc).limit(50) }

  private

  def set_values
    self.facility = target.device.facility unless facility
    self.target_status = target.status unless target_status
    self.facility_status = facility.status unless facility_status
  end

  def send_notification
    FacilityChannel.broadcast_to(self.facility_id, {
      e: :event_created,
      html: ApplicationController.new.render_to_string(partial: 'mobile/facilities/event', object: self)
    })
  end
end
