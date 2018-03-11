# == Schema Information
#
# Table name: events
#
#  id              :uuid             not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  target_type     :string
#  target_id       :uuid             not null
#  facility_id     :uuid             not null
#  target_status   :integer          default(NULL), not null
#  facility_status :integer          default(NULL), not null
#  dashboard       :boolean          default(FALSE), not null
#

FactoryBot.define do
  factory :event do
    association :target, factory: :sensor
  end
end
