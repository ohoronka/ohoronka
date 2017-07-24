require 'rails_helper'

RSpec.describe SensorsController, type: :controller do
  describe '#index' do
    let(:facility) { create(:facility) }

    it 'returns ok' do
      get :index, params: {facility_id: facility.id}, session: user_session
      expect(response).to have_http_status(:ok)
    end
  end
end
