# == Schema Information
#
# Table name: facilities
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#  status     :integer          default("idle"), not null
#

FactoryGirl.define do
  factory :facility do
    sequence(:name) {|n| "facility ##{n}"}

    before(:create) do |facility|
      facility.users << (User.take || create(:user))
    end
  end
end
