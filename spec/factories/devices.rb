FactoryGirl.define do
  factory :device do
    association :facility, factory: :facility

    sequence(:name) {|n| "device ##{n}"}
  end
end
