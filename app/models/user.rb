class User < ApplicationRecord
  has_secure_password

  belongs_to :account, inverse_of: :users
  has_many :facilities, through: :account
  has_many :devices, through: :facilities
  has_many :sensors, through: :devices
end
