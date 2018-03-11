# == Schema Information
#
# Table name: mqtt_acls
#
#  id           :uuid             not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  mqtt_user_id :uuid             not null
#  user_name    :string
#  topic        :string
#  rw           :integer          default("none")
#

class Mqtt::Acl < ApplicationRecord
  RW = {
    none: 0,
    read: 1,
    full: 2
  }
  enum rw: RW, _suffix: true

  belongs_to :mqtt_user, :class_name => 'Mqtt::User', inverse_of: :acls, foreign_key: :mqtt_user_id

  before_validation :set_user_name

  validates :user_name, presence: true, uniqueness: {scope: :topic}

  private

  def set_user_name
    self.user_name = mqtt_user.user_name
  end
end
