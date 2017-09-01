FactoryGirl.define do
  factory :mqtt_acl, class: 'Mqtt::Acl' do
    mqtt_user nil
    user_name "MyString"
    topic "MyString"
    rw 1
  end
end
