FactoryGirl.define do
  factory :sensor do
    association :device

    sequence(:name) {|n| "Sensor ##{n}"}
  end
end
