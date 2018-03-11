# == Schema Information
#
# Table name: mqtt_acls
#
#  id           :uuid             not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  mqtt_user_id :uuid             not null
#  user_name    :string
#  topic        :string
#  rw           :integer          default("none")
#

FactoryBot.define do
  factory :mqtt_acl, class: 'Mqtt::Acl' do
    mqtt_user nil
    user_name "MyString"
    topic "MyString"
    rw 1
  end
end
