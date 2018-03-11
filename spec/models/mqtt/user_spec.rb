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
  pending "add some examples to (or delete) #{__FILE__}"
end
