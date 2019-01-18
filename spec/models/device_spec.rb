# == Schema Information
#
# Table name: devices
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  pinged_at   :datetime
#  number      :integer          not null
#  facility_id :uuid
#  name        :string
#  status      :integer          default("offline"), not null
#  gpio_listen :integer          default(0), not null
#  fw_version  :integer          default(0)
#  user_id     :uuid
#

require 'rails_helper'

RSpec.describe Device, type: :model do
  let(:device) { create(:device) }

  it 'creates device' do
    device = create(:device)
    expect(device.number).not_to be_nil
  end
end
