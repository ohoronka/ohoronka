# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  target_type :string(255)
#  target_id   :integer
#  event       :integer          default(NULL)
#  unread      :boolean          default(TRUE)
#  params      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :notification do
    user nil
    target ""
    message "MyString"
    read false
  end
end
