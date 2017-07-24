require 'rails_helper'

RSpec.describe Mobile::FacilitiesController, type: :controller do
  render_views

  let(:account) { create(:account) }
  let(:facility) { create(:facility, account: account) }

  describe '#index' do
    context 'one facility' do
      it 'redirects to facility if its only one' do
        facility
        get :index, session: user_session
        expect(response).to redirect_to(mobile_facility_path(facility))
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
