require 'rails_helper'

RSpec.describe Mobile::SessionController, type: :controller do
  let(:user) { create(:user) }

  context 'already signed in user' do
    it 'redirects to home' do
      get :sign_in_form, session: {user_id: user.id}
      expect(response).to redirect_to(mobile_root_path)
    end
  end

  describe '#sign_in_form' do
    it 'renders the page' do
      get :sign_in_form
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#sign_in' do
    it 'signs user in' do
      post :sign_in, params: {session: {user_name: user.email, password: 'password'}}
      expect(response).to redirect_to(mobile_root_path)
    end

    it 'renders errors' do
      post :sign_in, params: {session: {user: user.email, password: 'wrong password'}}
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#sign_out' do
    it 'sign_outs the user' do
      get :sign_out
      expect(response).to redirect_to(mobile_sign_in_path)
    end
  end
end
