# == Schema Information
#
# Table name: notifications
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :uuid             not null
#  target_type :string
#  target_id   :uuid
#  source_type :string
#  source_id   :uuid
#  event       :integer          default(NULL)
#  unread      :boolean          default(TRUE)
#  options     :json
#

FactoryBot.define do
  factory :notification do
    user { nil }
    target { "" }
    message { "MyString" }
    read { false }
  end
end
