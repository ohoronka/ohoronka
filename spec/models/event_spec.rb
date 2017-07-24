require 'rails_helper'

RSpec.describe Event, type: :model do
  it 'has valid factory' do
    expect{ create(:event) }.to change(Event, :count).by(1)
  end
end
