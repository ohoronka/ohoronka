# == Schema Information
#
# Table name: mqtt_acls
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  mqtt_user_id :integer
#  user_name    :string(255)
#  topic        :string(255)
#  rw           :integer          default("none")
#

FactoryGirl.define do
  factory :mqtt_acl, class: 'Mqtt::Acl' do
    mqtt_user nil
    user_name "MyString"
    topic "MyString"
    rw 1
  end
end
