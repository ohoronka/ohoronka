# == Schema Information
#
# Table name: channels
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  type       :string
#  auth_token :string
#  identifier :string
#  activated  :boolean          default(FALSE)
#

FactoryBot.define do
  factory :channel do
    association :user

    factory :telegram_channel, class: Channel::Telegram
  end
end
