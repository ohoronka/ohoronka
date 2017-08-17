require 'rails_helper'

RSpec.describe FacilitiesController, type: :controller do
  render_views

  let(:facility) { create(:facility) }

  describe '#index' do
    context 'one facility' do
      it 'redirects to facility if its only one' do
        facility
        get :index, session: user_session
        expect(response).to redirect_to(facility_path(facility))
      end
    end

    context '0 facilities' do
      it 'shows list' do
        get :index, session: user_session
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#show' do
    let!(:event) { create(:event) }
    let(:facility) { event.facility}

    it 'returns ok' do
      get :show, params: {id: facility.id}, session: user_session
      expect(response).to have_http_status(:ok)
    end
  end
end
