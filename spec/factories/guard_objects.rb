FactoryGirl.define do
  factory :guard_object do
    sequence(:name) {|n| "object ##{n}"}
  end
end
