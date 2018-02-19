# == Schema Information
#
# Table name: mobile_devices
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  token      :string
#

FactoryGirl.define do
  factory :mobile_device do
    user nil
    token "MyString"
  end
end
