FactoryGirl.define do
  factory :channel do
    association :user
    type Channel::Telegram
  end
end
