# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  target_type :string
#  target_id   :integer
#  event       :integer          default(NULL)
#  unread      :boolean          default(TRUE)
#  params      :string
#

FactoryBot.define do
  factory :notification do
    user nil
    target ""
    message "MyString"
    read false
  end
end
