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

require 'rails_helper'

RSpec.describe Facility, type: :model do
  describe 'validations' do
    describe '#validate_status' do
      let(:facility) { build(:facility, status: 'protected') }
      let(:sensor_ok) { build(:sensor, status: 'ok') }
      let(:sensor_alarm) { build(:sensor, status: 'alarm') }

      it 'is invalid when try to protect with alarmed sensors' do
        allow(facility).to receive(:sensors).and_return([sensor_alarm, sensor_ok])
        expect(facility.valid?).to be_falsey
        expect(facility.errors[:status]).to include(I18n.t('sensors_must_be_ok'))
      end
    end
  end
end
