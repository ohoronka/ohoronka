class Friendship < ApplicationRecord
  STATUSES = {
    pending: 0,
    accepted: 1
  }

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  enum status: STATUSES, _suffix: true
end
