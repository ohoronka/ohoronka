# == Schema Information
#
# Table name: channels
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#  type       :string           not null
#  auth_token :string
#  identifier :string
#  active     :boolean          default(FALSE), not null
#

FactoryBot.define do
  factory :channel do
    association :user

    factory :telegram_channel, class: Channel::Telegram
  end
end
