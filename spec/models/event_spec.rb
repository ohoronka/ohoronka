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

require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'has valid factory' do
    expect{ create(:event) }.to change(Event, :count).by(1)
  end

  describe 'scope dashboard list' do
    it 'returns only facility alarm and protected status and in a backward order' do
      event1 = create(:event)
      facility = event1.facility
      facility.update_columns(status: :protected)
      event2 = create(:event, facility: facility, target: event1.target)
      facility.update_columns(status: :alarm)
      event3 = create(:event, facility: facility, target: event1.target)
      expect(facility.events.dashboard_list.to_a).to eq([event3, event2])
    end
  end
end
