FactoryGirl.define do
  factory :mqtt_user, class: 'Mqtt::User' do
    user "MyString"
    password "MyString"
    password_hash "MyString"
  end
end
