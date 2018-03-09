# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  first_name      :string
#  email           :string
#  password_digest :string
#  admin           :boolean          default(FALSE)
#  last_name       :string
#  about           :text
#  avatar          :string
#  background      :string
#  auth_token      :string
#

FactoryBot.define do
  factory :user do
    sequence(:first_name) {|n| "name##{n}"}
    sequence(:last_name) {|n| "surename##{n}"}
    sequence(:email) {|n| "user#{n}@example.com"}
    password "password"
  end
end
