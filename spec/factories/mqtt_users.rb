# == Schema Information
#
# Table name: mqtt_users
#
#  id            :uuid             not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  device_id     :uuid
#  user_name     :string
#  password      :string
#  password_hash :string
#  admin         :boolean          default(FALSE)
#

FactoryBot.define do
  factory :mqtt_user, class: 'Mqtt::User' do
    user { "MyString" }
    password { "MyString" }
    password_hash { "MyString" }
  end
end
