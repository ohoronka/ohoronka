class User < ApplicationRecord
  has_secure_password

  belongs_to :account, inverse_of: :users
  has_many :objects, through: :account
  has_many :devices, through: :objects
  has_many :sensors, through: :devices
end
