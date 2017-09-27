class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true

  enum event: {friendship_request: 1, accepted_friendship: 2, facility_share: 3}

  scope :unread, -> { where(unread: true) }

  serialize :params, JSON
end
