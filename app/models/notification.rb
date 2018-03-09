# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  target_type :string
#  target_id   :integer
#  event       :integer          default(NULL)
#  unread      :boolean          default(TRUE)
#  params      :string
#

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true

  enum event: {friendship_request: 1, accepted_friendship: 2, facility_share: 3} # friendship relation is deprecated

  scope :unread, -> { where(unread: true) }

  serialize :params, JSON
end
