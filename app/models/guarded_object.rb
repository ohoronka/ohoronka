class GuardedObject < ApplicationRecord
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

  has_many :devices, foreign_key: :object_id, inverse_of: :object, dependent: :destroy
  has_many :sensors, through: :devices
  has_many :events, foreign_key: :object_id, inverse_of: :object
  belongs_to :account, inverse_of: :objects

  enum status: STATUSES, _suffix: true

  def alarm!
    if protected_status?
      alarm_status!
      AccountChannel.broadcast_to(self.account_id, {e: :alarm, object: self.as_json})
    end
  end

  def next_status
    STATUS_FLOW[status.to_sym].first.to_s
  end
end
