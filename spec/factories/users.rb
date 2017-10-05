# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  admin           :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  about           :text(65535)
#  avatar          :string(255)
#  background      :string(255)
#  auth_token      :string(255)
#

FactoryGirl.define do
  factory :user do
    sequence(:first_name) {|n| "name##{n}"}
    sequence(:last_name) {|n| "surename##{n}"}
    sequence(:email) {|n| "user#{n}@example.com"}
    password "password"
  end
end
