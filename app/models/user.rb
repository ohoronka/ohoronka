class User < ApplicationRecord
  has_secure_password

  has_many :facility_shares, inverse_of: :user, dependent: :destroy
  has_many :facilities, through: :facility_shares
  has_many :devices, through: :facilities
  has_many :sensors, through: :devices
  has_many :channels, dependent: :destroy

  def allowed_channel_types
    Channel.descendants.map(&:name) - channels.pluck(:type)
  end
end
