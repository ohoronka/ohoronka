# == Schema Information
#
# Table name: mqtt_users
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  device_id     :integer
#  user_name     :string
#  password      :string
#  password_hash :string
#

require 'rails_helper'

RSpec.describe Mqtt::User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
