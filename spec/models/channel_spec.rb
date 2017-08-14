require 'rails_helper'

RSpec.describe Channel, type: :model do
  context 'telegram' do
    it 'set auth token' do
      channel = create(:telegram_channel)
      expect(channel.auth_token).not_to be(nil)
    end
  end
end
