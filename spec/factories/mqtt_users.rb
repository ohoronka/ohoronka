# == Schema Information
#
# Table name: mqtt_users
#
#  id            :uuid             not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  device_id     :uuid             not null
#  user_name     :string
#  password      :string
#  password_hash :string
#

FactoryBot.define do
  factory :mqtt_user, class: 'Mqtt::User' do
    user "MyString"
    password "MyString"
    password_hash "MyString"
  end
end
