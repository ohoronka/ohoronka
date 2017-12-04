# == Schema Information
#
# Table name: facilities
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#  status     :integer          default("idle"), not null
#

class Facility < ApplicationRecord
  STATUSES = ALL_STATUSES.slice(:idle, :protected, :alarm)

  ALARM_STATUSES = ALL_STATUSES.slice(:alarm, :offline)

  STATUS_FLOW = {
    idle: [:protected],
    protected: [:idle, :alarm],
    alarm: [:idle]
  }

  has_many :devices, foreign_key: :facility_id, inverse_of: :facility, dependent: :destroy
  has_many :sensors, through: :devices
  has_many :events, foreign_key: :facility_id, inverse_of: :facility
  has_many :shares, class_name: 'FacilityShare', inverse_of: :facility, dependent: :destroy
  has_many :users, through: :shares, inverse_of: :facilities

  enum status: STATUSES, _suffix: true

  scope :shared, -> { where.not(facility_shares: {role: FacilityShare::ROLES[:owner]}) }
  scope :owned, -> { where(facility_shares: {role: FacilityShare::ROLES[:owner]}) }

  after_update :create_event

  def alarm!
    if protected_status?
      alarm_status!
      users.each do |user|
        user.channels.each do |channel|
          channel.notify_facility_alarm(self)
        end
      end
    end
  end

  def next_status
    STATUS_FLOW[status.to_sym].first.to_s
  end

  def alarm_service
    @alarm_service ||= AlarmService.new(facility: self)
  end

  private

  def create_event
    def create_event
      return unless saved_changes.key?(:status)
      events.create(facility: self, target: self)
      notify_web
    end
  end

  def notify_web
    # TODO implement
  end
end
