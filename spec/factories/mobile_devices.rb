# == Schema Information
#
# Table name: mobile_devices
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#  token      :string
#

FactoryBot.define do
  factory :mobile_device do
    user nil
    token "MyString"
  end
end
