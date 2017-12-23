# == Schema Information
#
# Table name: mqtt_acls
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  mqtt_user_id :integer
#  user_name    :string
#  topic        :string
#  rw           :integer          default("none")
#

require 'rails_helper'

RSpec.describe Mqtt::Acl, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
