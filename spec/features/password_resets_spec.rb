require 'rails_helper'

RSpec.feature "PasswordResets", type: :feature do
  describe 'sends password reset message' do
    let(:user) { create(:user) }

    it 'sends email' do
      visit root_paths
      click_on 'password-reset-link'
      expect(page).to have_current_path(new_password_reset_path)

      expect{
        fill_in 'email', with: user.email
        click_on I18n.t('password_reset')
      }.to change(ActionMailer::Base.deliveries, :count).by(1)

      user.reload

      expect(user.password_reset_token).not_to be_nil
      expect(user.password_reset_token_expires_at).to be_between(1.day.from_now - 5.seconds, 1.day.from_now + 5.seconds)
    end
  end

  describe 'changing users password' do
    let(:user) { build(:user) }

    it 'resets the password' do
      user.generate_password_reset_token
      user.save

      visit(edit_password_reset_path(token: user.password_reset_token))
      sleep 5
      fill_in 'user_password', with: 'new_password'
      fill_in 'user_password_confirmation', with: 'new_password'
      click_on I18n.t('change_password')

      sleep 5

      expect(page).to have_current_path(root_path)
      user.reload

      expect(user.authenticate('new_password')).to be_truthy
      expect(user).to have_attributes(password_reset_token: nil, password_reset_token_expires_at: nil)
    end
  end
end
