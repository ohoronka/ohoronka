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

FactoryBot.define do
  factory :user do
    sequence(:first_name) {|n| "name##{n}"}
    sequence(:last_name) {|n| "surename##{n}"}
    sequence(:email) {|n| "user#{n}@example.com"}
    password { "password" }
  end
end
