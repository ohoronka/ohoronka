# == Schema Information
#
# Table name: users
#
#  id                              :uuid             not null, primary key
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  first_name                      :string
#  last_name                       :string
#  email                           :string
#  password_digest                 :string
#  admin                           :boolean          default(FALSE)
#  avatar                          :string
#  auth_token                      :string
#  password_reset_token            :string
#  password_reset_token_expires_at :datetime
#

require 'rails_helper'

RSpec.describe User, type: :model do

  describe '#cart' do
    let(:user) { create(:user) }

    it 'creates a cart' do
      expect{
        user.cart
      }.to change(user.orders.cart, :count).by(1)
    end
  end
end
