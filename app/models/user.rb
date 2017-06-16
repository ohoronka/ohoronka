class User < ApplicationRecord
  has_secure_password

  belongs_to :account, inverse_of: :users
  has_many :objects, through: :account
end