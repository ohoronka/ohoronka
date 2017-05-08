class GuardedObject < ApplicationRecord
  has_many :devices, foreign_key: :object_id, inverse_of: :object, dependent: :destroy
  belongs_to :account, inverse_of: :objects

  enum status: [:idle, :protected, :alarm], _suffix: true

  def alarm!
    alarm_status! if protected_status?
  end
end
