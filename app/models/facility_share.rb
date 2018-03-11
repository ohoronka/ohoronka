# == Schema Information
#
# Table name: facility_shares
#
#  id          :uuid             not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :uuid             not null
#  facility_id :uuid             not null
#  role        :integer          default("owner")
#

class FacilityShare < ApplicationRecord
  ROLES = {
    owner: 0,
    guard: 1
  }

  belongs_to :user
  belongs_to :facility

  enum role: ROLES

  attr_accessor :user_uuid_or_email

  before_validation :find_user_by_uuid_or_email
  validates :facility_id, uniqueness: {scope: :user_id}

  private

  def find_user_by_uuid_or_email
    return if user_uuid_or_email.blank?

    self.user = User.where(id: user_uuid_or_email).or(User.where(email: user_uuid_or_email)).take
    errors.add(:user_uuid_or_email, I18n.t('facility_share.user_not_found')) unless self.user
  end
end
