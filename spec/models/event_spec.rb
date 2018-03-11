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

  describe 'notify_web' do
    it 'notifies web when facility alarmed or protected event was created' do
      expect(FacilityChannel).to receive(:broadcast_to)
      event = create(:event, facility: build(:facility, status: :protected))
    end

    it 'does not notify web when facility ideled event was created' do
      expect(FacilityChannel).to_not receive(:broadcast_to)
      create(:event, facility: build(:facility, status: :idle))
    end
  end
end
