require 'rails_helper'

RSpec.describe Mobile::SessionController, type: :controller do
  let(:user) { create(:user) }

  context 'already signed in user' do
    it 'redirects to home' do
      get :sign_in_form, session: {user_id: user.id}
      expect(response).to redirect_to(root_path)
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
      post :sign_in, params: {session: {user: user.email, password: 'password'}}
      expect(response).to redirect_to(root_path)
    end

    it 'renders errors' do
      post :sign_in, params: {session: {user: user.email, password: 'wrong password'}}
      expect(response).to have_http_status(:ok)
    end
  end

  describe '#logout' do
    it 'logouts the user' do
      get :logout
      expect(response).to redirect_to(mobile_sign_in_path)
    end
  end
end
