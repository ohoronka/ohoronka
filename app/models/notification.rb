class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true

  enum status: {unread: 0, read: 1}
end
