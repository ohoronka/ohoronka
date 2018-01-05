class MobileDevice < ApplicationRecord
  belongs_to :user

  def self.set_for_user(token:, user:)
    mobile_device = MobileDevice.find_or_initialize_by(token: token)
    mobile_device.user = user
    mobile_device.save! if mobile_device.changed?
  end

  def send_once(msg:)
    pusher = FcmPusher.new(FCM_CONFIG[:key])
    pusher.send_once(self.token, "OHORONKA", msg, { badge: 1, sound: 'enabled', priority: FcmPusher::Priority::HIGH })
  end

  def self.send_all(tokens:, msg:)
    pusher = FcmPusher.new(FCM_CONFIG[:key])
    pusher.send_all(tokens, "OHORONKA", msg, { badge: 1, sound: 'enabled', priority: FcmPusher::Priority::HIGH })
  end
end
