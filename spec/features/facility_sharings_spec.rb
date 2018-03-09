require 'rails_helper'

RSpec.feature "FacilitySharings", type: :feature do
  let(:user) { create(:user) }
  let(:user2) { create(:user) }
  describe 'sharing facility with another user' do
    let(:facility) { create(:facility, user: user) }

    it 'shares facility with friend' do
      facility
      login_as(user.email, 'password')
      click_on t('shares')
      click_on t('facility_share.share_with')
      fill_in 'facility_share_user_uuid_or_email', with: user2.email
      click_on t('actions.save')

      expect(page).to have_current_path(facility_facility_shares_path(facility))
      expect(page).to have_text(user2.decorate.full_name)

      expect(user2.facility_shares.last).to have_attributes(facility_id: facility.id, role: 'owner')
      expect(user2.notifications.last).to have_attributes(
        target: user2.facility_shares.last,
        event: 'facility_share',
        unread: true,
        params: {'initiator' => user.id}
      )

      click_on 'profile_button'
      click_on t('sign_out')

      login_as(user2.email, 'password')
      expect(page).to have_text(facility.name)
      visit notifications_path
      expect(page).to have_text(user.decorate.full_name)
    end

    it "validates entered friends's email" do
      facility
      login_as(user.email, 'password')
      visit(new_facility_facility_share_path(facility))

      # wrong user
      fill_in 'facility_share_user_uuid_or_email', with: 'wrong@email.com'
      click_on t('actions.save')
      expect(page).to have_text(t('facility_share.user_not_found'))

      # already shared
      fill_in 'facility_share_user_uuid_or_email', with: user.email
      click_on t('actions.save')
      expect(page).to have_text(t('facility_share.already_shared'))
    end
  end

  describe 'remove share' do
    let(:facility) { create(:facility, users: [user, user2]) }

    it 'removes share' do
      facility
      login_as(user.email, 'password')
      visit facility_facility_shares_path(facility)
      expect(page).not_to have_css("#destroy_#{user.facility_shares.take.id}") # can't remove yourself
      expect{
        click_on "destroy_#{user2.facility_shares.take.id}"
      }.to change(FacilityShare, :count).by(-1)
      expect(user2.facilities.blank?).to be_truthy
    end
  end
end
