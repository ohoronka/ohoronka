class Facility < ApplicationRecord
  ALL_STATUSES = {
    idle: 1,
    protected: 2,
    alarm: 3,
    ok: 4,
    online: 5,
    offline: 6
  }

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
  has_many :facility_shares, inverse_of: :facility, dependent: :destroy
  has_many :users, through: :facility_shares, inverse_of: :facilities
  enum status: STATUSES, _suffix: true

  def alarm!
    if protected_status?
      alarm_status!
      users.each do |user|
        user.channels.each do |channel|
          channel.notify("Alarm on facility #{name}!")
        end
      end
    end
  end

  def next_status
    STATUS_FLOW[status.to_sym].first.to_s
  end
end
