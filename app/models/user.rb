class User < ApplicationRecord
  has_secure_password
  mount_uploader :avatar, AvatarUploader
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar

  has_many :facility_shares, inverse_of: :user, dependent: :destroy
  has_many :facilities, through: :facility_shares
  has_many :devices, through: :facilities
  has_many :sensors, through: :devices
  has_many :channels, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, class_name: 'User', through: :friendships
  has_many :friend_requests, class_name: 'Friendship', foreign_key: :friend_id
  has_many :notifications, dependent: :destroy, inverse_of: :user

  validates :email, uniqueness: {case_sensitive: false}

  def allowed_channel_types
    Channel.descendants.map(&:name) - channels.pluck(:type)
  end

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end
end
