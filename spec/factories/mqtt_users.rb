# == Schema Information
#
# Table name: mqtt_users
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  device_id     :integer
#  user_name     :string(255)
#  password      :string(255)
#  password_hash :string(255)
#

FactoryGirl.define do
  factory :mqtt_user, class: 'Mqtt::User' do
    user "MyString"
    password "MyString"
    password_hash "MyString"
  end
end
