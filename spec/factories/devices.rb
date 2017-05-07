FactoryGirl.define do
  factory :device do
    association :object, factory: :guarded_object

    sequence(:name) {|n| "device ##{n}"}
  end
end
