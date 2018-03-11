# == Schema Information
#
# Table name: facilities
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#  status     :integer          default("idle"), not null
#

require 'rails_helper'

RSpec.describe Facility, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
