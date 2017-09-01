class Mqtt::Acl < ApplicationRecord
  RW = {
    none: 0,
    read: 1,
    full: 2
  }
  enum rw: RW, _suffix: true

  belongs_to :mqtt_user, :class_name => 'Mqtt::User', inverse_of: :acls, foreign_key: :mqtt_user_id

  before_save :set_user_name

  validates :user_name, presence: true, uniqueness: {scope: :topic}

  private

  def set_user_name
    self.user_name = mqtt_user.user_name
  end
end
