# == Schema Information
#
# Table name: channels
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#  type       :string           not null
#  auth_token :string
#  identifier :string
#  active     :boolean          default(FALSE), not null
#

require 'rails_helper'

RSpec.describe Channel, type: :model do
  context 'telegram' do
    it 'set auth token' do
      channel = create(:telegram_channel)
      expect(channel.auth_token).not_to be(nil)
    end
  end
end
