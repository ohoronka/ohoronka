# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  friend_id  :integer
#  status     :integer          default("pending")
#

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
