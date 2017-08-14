FactoryGirl.define do
  factory :facility do
    sequence(:name) {|n| "facility ##{n}"}
  end
end
