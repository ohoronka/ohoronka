FactoryGirl.define do
  factory :device do
    association :object, factory: :guard_object

    sequence(:name) {|n| "device ##{n}"}
  end
end
