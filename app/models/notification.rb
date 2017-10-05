# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  target_type :string(255)
#  target_id   :integer
#  event       :integer          default(NULL)
#  unread      :boolean          default(TRUE)
#  params      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true

  enum event: {friendship_request: 1, accepted_friendship: 2, facility_share: 3}

  scope :unread, -> { where(unread: true) }

  serialize :params, JSON
end
