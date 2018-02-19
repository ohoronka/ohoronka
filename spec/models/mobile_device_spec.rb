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

require 'rails_helper'

RSpec.describe MobileDevice, type: :model do
  describe '.set_for_user' do
    let(:user) { create(:user) }
    let(:token) { '123' }

    it 'creates new mobile device' do
      expect{
        MobileDevice.set_for_user(token: token, user: user)
      }.to change(MobileDevice, :count).by(1).and change{user.mobile_devices.count}.by(1)
    end

    it 'changes mobile device owner' do
      user2 = create(:user)
      MobileDevice.set_for_user(token: token, user: user2)
      expect{
        MobileDevice.set_for_user(token: token, user: user)
      }.to change(MobileDevice, :count).by(0).and change{user.mobile_devices.count}.by(1).
          and change{user2.mobile_devices.count}.by(-1)
    end
  end
end
