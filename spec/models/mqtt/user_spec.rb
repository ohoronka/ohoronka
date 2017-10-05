# == Schema Information
#
# Table name: mqtt_users
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  device_id     :integer
#  user_name     :string(255)
#  password      :string(255)
#  password_hash :string(255)
#

require 'rails_helper'

RSpec.describe Mqtt::User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
