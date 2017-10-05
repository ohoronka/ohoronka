# == Schema Information
#
# Table name: events
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  target_type     :string(255)
#  target_id       :integer
#  facility_id     :integer
#  target_status   :integer          default(NULL), not null
#  facility_status :integer          default(NULL), not null
#

FactoryGirl.define do
  factory :event do
    association :target, factory: :sensor
  end
end
