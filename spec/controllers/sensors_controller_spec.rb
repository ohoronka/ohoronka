require 'rails_helper'

RSpec.describe SensorsController, type: :controller do
  render_views

  let(:sensor) { create(:sensor) }
  let(:facility) { sensor.device.facility }

  describe '#index' do
    it 'returns ok' do
      get :index, params: {facility_id: facility.id}, session: user_session
      expect(response).to have_http_status(:ok)
    end
  end
end
