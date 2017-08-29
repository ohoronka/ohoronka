class Friendship < ApplicationRecord
  STATUSES = {
    pending: 0,
    accepted: 1,
    rejected: 2
  }

  belongs_to :user
  belongs_to :friend, class_name: 'User'
  has_one :pair, class_name: 'Friendship', foreign_key: :user_id, primary_key: :friend_id

  enum status: STATUSES, _suffix: true
end
