class MobileDevice < ApplicationRecord
  belongs_to :user

  def self.set_for_user(token:, user:)
    mobile_device = MobileDevice.find_or_initialize_by(token: token)
    mobile_device.user = user
    mobile_device.save! if mobile_device.changed?
  end
end
