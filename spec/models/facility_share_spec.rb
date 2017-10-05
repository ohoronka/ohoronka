# == Schema Information
#
# Table name: facility_shares
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  facility_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  role        :integer          default("owner")
#

require 'rails_helper'

RSpec.describe FacilityShare, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
