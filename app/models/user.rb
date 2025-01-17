# == Schema Information
#
# Table name: users
#
#  id                              :uuid             not null, primary key
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  first_name                      :string
#  last_name                       :string
#  email                           :string
#  password_digest                 :string
#  admin                           :boolean          default(FALSE)
#  avatar                          :string
#  auth_token                      :string
#  password_reset_token            :string
#  password_reset_token_expires_at :datetime
#

class User < ApplicationRecord
  has_secure_password

  mount_uploader :avatar, AvatarUploader

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_avatar

  before_create  :generate_auth_token

  has_many :facility_shares, inverse_of: :user, dependent: :destroy
  has_many :facilities, through: :facility_shares
  has_many :devices, dependent: :nullify
  has_many :sensors, through: :devices
  has_many :channels, dependent: :destroy
  has_many :notifications, dependent: :destroy, inverse_of: :user
  has_many :mobile_devices, dependent: :destroy
  has_many :orders

  validates :email, uniqueness: {case_sensitive: false}, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true, length: {minimum: 8}, on: :create
  validates :password, allow_blank: true, length: {minimum: 8}, on: :update
  validates :first_name, presence: true
  validates :last_name, presence: true

  def allowed_channel_types
    Channel::SUB_CLASSES - channels.all.map(&:class)
  end

  def crop_avatar
    avatar.recreate_versions! if crop_x.present?
  end

  def generate_auth_token
    self.auth_token = SecureRandom.urlsafe_base64
  end

  def cart
    @cart ||= orders.cart.take || orders.cart.create!
  end

  def cart_service
    @cart_service ||= CartService.new(cart: cart)
  end

  def send_password_reset
    generate_password_reset_token if password_reset_token.nil? || password_reset_token_expires_at < 1.hour.from_now
    save!
    UserMailer.send_password_reset(self).deliver_later
  end

  def generate_password_reset_token
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_token_expires_at = 1.day.from_now
  end
end
