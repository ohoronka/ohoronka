FactoryGirl.define do
  factory :guarded_object do
    association :account
    sequence(:name) {|n| "object ##{n}"}
  end
end
