# == Schema Information
#
# Table name: notifications
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :uuid             not null
#  target_type :string
#  target_id   :uuid
#  source_type :string
#  source_id   :uuid
#  event       :integer          default(NULL)
#  unread      :boolean          default(TRUE)
#  options     :json
#

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true
  belongs_to :source, polymorphic: true

  enum event: {friendship_request: 1, accepted_friendship: 2, facility_share: 3} # friendship relation is deprecated

  scope :unread, -> { where(unread: true) }
end
