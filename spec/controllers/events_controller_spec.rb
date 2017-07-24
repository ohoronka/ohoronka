require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  render_views

  describe '#index' do
    let(:event) { create(:event) }
    let(:facility) { event.facility }

    it 'returns ok' do
      get :index, params: {facility_id: facility.id}, session: user_session
      expect(response).to have_http_status(:ok)
    end
  end
end
