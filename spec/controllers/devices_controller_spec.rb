require 'rails_helper'

RSpec.describe DevicesController, type: :controller do
  describe '#index' do
    let(:device) { create(:device) }

    it 'returns ok' do
      get :index, params: {facility_id: device.facility_id}, session: user_session
      expect(response).to have_http_status(:ok)
    end
  end
end
