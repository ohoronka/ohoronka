# == Schema Information
#
# Table name: mqtt_users
#
#  id            :uuid             not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  device_id     :uuid             not null
#  user_name     :string
#  password      :string
#  password_hash :string
#

require 'rails_helper'

RSpec.describe Mqtt::User, type: :model do
  it 'sets a password' do
    user = Mqtt::User.new
    user.valid?
    expect(user.password).not_to be_empty
    expect(user.password_hash).not_to be_empty
  end
end
