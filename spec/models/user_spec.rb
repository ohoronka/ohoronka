# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  first_name      :string
#  email           :string
#  password_digest :string
#  admin           :boolean          default(FALSE)
#  last_name       :string
#  about           :text
#  avatar          :string
#  background      :string
#  auth_token      :string
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
