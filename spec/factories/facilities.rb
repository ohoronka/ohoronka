FactoryGirl.define do
  factory :facility do
    association :account
    sequence(:name) {|n| "facility ##{n}"}
  end
end
