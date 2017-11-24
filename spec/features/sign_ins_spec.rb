require 'rails_helper'

RSpec.feature "SignIns", type: :feature do
  describe 'sign in process' do
    let(:user) { create(:user, password: 'password') }

    it 'sign in user with correct credentials' do
      login_as(user.email, 'password')
      expect(page).to have_text(user.decorate.full_name)
    end

    it "doesn't sign in user with wrong email" do
      login_as('wrong@email.com', 'password')
      expect(page).not_to have_text(user.decorate.full_name)
      expect(page).to have_text(I18n.t('msg.wrong_email_or_password'))
    end

    it "doesn't sign in user with wrong password" do
      login_as(user.email, 'wrong_password')
      expect(page).not_to have_text(user.decorate.full_name)
      expect(page).to have_text(I18n.t('msg.wrong_email_or_password'))
    end
  end
end
