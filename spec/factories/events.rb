FactoryGirl.define do
  factory :event do
    association :target, factory: :sensor
  end
end
