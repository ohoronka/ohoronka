# == Schema Information
#
# Table name: events
#
#  id              :uuid             not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  target_type     :string
#  target_id       :uuid             not null
#  facility_id     :uuid             not null
#  target_status   :integer          default(NULL), not null
#  facility_status :integer          default(NULL), not null
#  dashboard       :boolean          default(FALSE), not null
#

class Event < ApplicationRecord
  belongs_to :target, polymorphic: true, inverse_of: :events
  belongs_to :facility, inverse_of: :events

  enum facility_status: Facility::STATUSES, _suffix: true
  enum target_status: ALL_STATUSES, _suffix: true

  before_validation :set_values, on: [:create]
  after_create :notify_web

  scope :dashboard_list, ->{ where(facility_status: [:alarm, :protected]).preload(:target).ordered.limit(50) }
  scope :ordered, ->{ order(created_at: :desc) }

  def notify_web
    DashboardEventsChannel.broadcast_to(self.facility_id, {
      e: :event_created,
      event: self.as_json(include: :target)
    }) if facility_status.in?(['protected', 'alarm'])
  end

  private

  def set_values
    self.facility = target.device.facility unless facility
    self.target_status = target.status unless target_status
    self.facility_status = facility.status unless facility_status
  end
end
