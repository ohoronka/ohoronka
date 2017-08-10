class User < ApplicationRecord
  has_secure_password

  belongs_to :account, inverse_of: :users
  has_many :facilities, through: :account
  has_many :devices, through: :facilities
  has_many :sensors, through: :devices
  has_many :channels, dependent: :destroy

  def allowed_channel_types
    Channel.descendants.map(&:name) - channels.pluck(:type)
  end
end
