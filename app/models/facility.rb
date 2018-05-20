# == Schema Information
#
# Table name: facilities
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
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
  has_many :events, foreign_key: :facility_id, inverse_of: :facility, dependent: :destroy
  has_many :shares, class_name: 'FacilityShare', inverse_of: :facility, dependent: :destroy
  has_many :users, through: :shares, inverse_of: :facilities

  enum status: STATUSES, _suffix: true

  scope :shared, -> { where.not(facility_shares: {role: FacilityShare::ROLES[:owner]}) }
  scope :owned, -> { where(facility_shares: {role: FacilityShare::ROLES[:owner]}) }

  after_update :create_event
  after_update :notify_web

  validate :validate_status

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

  def notify_web
    FacilityChannel.broadcast_to(self.facility_id, {
      e: :facility_updated,
      event: {
        id: id,
        target_name: target.name,
        target_status: target_status,
        t_target_status: decorate.target_status,
        created_at: created_at,
      }
    }) if facility_status.in?(['protected', 'alarm'])
  end

  private

  def validate_status
    errors.add :status, I18n.t('sensors_must_be_ok') if protected_status? && sensors.any?(&:alarm_status?)
  end

  def create_event
    def create_event
      return unless saved_changes.key?(:status)
      events.create(facility: self, target: self)
      notify_web
    end
  end

  def notify_web
    FacilityChannel.broadcast_to(self.id, {
      e: :facility_updated,
      facility: self.as_json
    })
  end
end
