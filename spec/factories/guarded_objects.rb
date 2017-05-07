FactoryGirl.define do
  factory :guarded_object do
    sequence(:name) {|n| "object ##{n}"}
  end
end
