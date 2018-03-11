# == Schema Information
#
# Table name: facilities
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  status     :integer          default("idle"), not null
#

FactoryBot.define do
  factory :facility do
    sequence(:name) {|n| "facility ##{n}"}

    transient do
      user false
    end

    before(:create) do |facility, evaluator|
      facility.users << (evaluator.user || User.take || create(:user)) if facility.users.blank?
    end
  end
end
