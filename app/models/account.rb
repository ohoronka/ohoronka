class Account < ApplicationRecord
  has_many :users, inverse_of: :account, dependent: :destroy
  has_many :facilities, class_name: 'Facility', inverse_of: :account, dependent: :destroy
end
