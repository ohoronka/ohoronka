FactoryGirl.define do
  factory :user do
    sequence(:first_name) {|n| "name##{n}"}
    sequence(:last_name) {|n| "surename##{n}"}
    sequence(:email) {|n| "user#{n}@example.com"}
    password "password"
  end
end
