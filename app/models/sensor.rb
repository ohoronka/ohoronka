class Sensor < ApplicationRecord
  belongs_to :device, inverse_of: :sensors, touch: true

  enum status: GuardedObject::ALL_STATUSES.slice(:alarm, :ok, :offline), _suffix: true
end
