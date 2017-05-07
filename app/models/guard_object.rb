class GuardObject < ApplicationRecord
  has_many :devices, foreign_key: :object_id, inverse_of: :object, dependent: :destroy

  def alarm!

  end
end
