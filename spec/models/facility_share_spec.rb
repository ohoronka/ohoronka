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

require 'rails_helper'

RSpec.describe FacilityShare, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
