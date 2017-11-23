require 'rails_helper'

RSpec.feature "SignIns", type: :feature do
  describe 'sign in process' do
    def try_login(login, password)
      visit '/'
      within('#new_session') do
        fill_in 'session_user_name', with: login
        fill_in 'session_password', with: password
        click_on 'Увійти'
      end
    end

    let(:user) { create(:user, password: 'password') }

    it 'sign in user with correct credentials' do
      try_login(user.email, 'password')
      expect(page).to have_text(user.decorate.full_name)
    end

    it "doesn't sign in user with wrong email" do
      try_login('wrong@email.com', 'password')
      expect(page).not_to have_text(user.decorate.full_name)
      expect(page).to have_text(I18n.t('msg.wrong_email_or_password'))
    end

    it "doesn't sign in user with wrong password" do
      try_login(user.email, 'wrong_password')
      expect(page).not_to have_text(user.decorate.full_name)
      expect(page).to have_text(I18n.t('msg.wrong_email_or_password'))
    end
  end
end
