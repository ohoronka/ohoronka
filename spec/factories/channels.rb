FactoryGirl.define do
  factory :channel do
    association :user

    factory :telegram_channel, class: Channel::Telegram
  end
end
