require 'rails_helper'

RSpec.feature "SignUps", type: :feature do
  describe 'sign Rup process' do
    let(:attr) { attributes_for(:user) }
    let(:user) { User.take }

    it 'signs up user' do
      visit '/'
      within('#new_user') do
        fill_in 'user_first_name', with: attr[:first_name]
        fill_in 'user_last_name', with: attr[:last_name]
        fill_in 'user_email', with: attr[:email]
        fill_in 'user_password', with: attr[:password]
      end

      expect{ click_on I18n.t('sessions.new.register') }.to change(User, :count).by(1)
      expect(user).to have_attributes(attr.except(:password))
      expect(page).to have_text(user.decorate.full_name)
    end
  end
end
