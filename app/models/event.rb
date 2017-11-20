# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  target_type     :string(255)
#  target_id       :integer
#  facility_id     :integer
#  target_status   :integer          default(NULL), not null
#  facility_status :integer          default(NULL), not null
#

class Event < ApplicationRecord
  belongs_to :target, polymorphic: true, inverse_of: :events
  belongs_to :facility, inverse_of: :events

  enum facility_status: Facility::STATUSES, _suffix: true
  enum target_status: ALL_STATUSES, _suffix: true

  before_validation :set_values, on: [:create]
  after_create :notify_web

  scope :dashboard_list, ->{ includes(:target).order(id: :desc).limit(50) }

  def notify_web
    FacilityChannel.broadcast_to(self.facility_id, {
      e: :event_created,
      event: {
        id: id,
        target_name: target.name,
        target_status: target_status,
        t_target_status: decorate.target_status,
        created_at: created_at,
      }
    })
  end

  private

  def set_values
    self.facility = target.device.facility unless facility
    self.target_status = target.status unless target_status
    self.facility_status = facility.status unless facility_status
  end
end
