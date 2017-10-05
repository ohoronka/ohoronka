# == Schema Information
#
# Table name: channels
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  type       :string(255)
#  auth_token :string(255)
#  identifier :string(255)
#  activated  :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :channel do
    association :user

    factory :telegram_channel, class: Channel::Telegram
  end
end
