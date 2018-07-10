# == Schema Information
#
# Table name: mqtt_users
#
#  id            :uuid             not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  device_id     :uuid             not null
#  user_name     :string
#  password      :string
#  password_hash :string
#

class Mqtt::User < ApplicationRecord
  belongs_to :device, inverse_of: :mqtt_user, optional: true
  has_many :acls, :class_name => 'Mqtt::Acl', inverse_of: :mqtt_user, dependent: :destroy, foreign_key: :mqtt_user_id

  before_create :set_password
  after_create :set_default_acl

  validates :user_name, presence: true, uniqueness: true

  private

  def set_password
    self.password ||= SecureRandom.base58(32)
    self.password_hash = Mqtt.password_hash(password)
  end

  def set_default_acl
    self.acls.create(topic: "#{self.device.number}/#", rw: :full) if device
  end
end
