class Account < ApplicationRecord
  has_many :users, inverse_of: :account, dependent: :destroy
  has_many :objects, class_name: 'GuardedObject', inverse_of: :account, dependent: :destroy
end
