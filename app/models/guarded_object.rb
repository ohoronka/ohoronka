class GuardedObject < ApplicationRecord
  ALL_STATUSES = {
    idle: 0,
    protected: 1,
    alarm: 2,
    ok: 3,
    online: 4,
    offline: 5
  }

  ALARM_STATUSES = ALL_STATUSES.slice(:alarm, :offline)

  STATUS_FLOW = {
    idle: [:protected],
    protected: [:idle, :alarm],
    alarm: [:idle]
  }

  has_many :devices, foreign_key: :object_id, inverse_of: :object, dependent: :destroy
  belongs_to :account, inverse_of: :objects

  enum status: ALL_STATUSES.slice(:idle, :protected, :alarm), _suffix: true

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
