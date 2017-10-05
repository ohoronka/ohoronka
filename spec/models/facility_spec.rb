# == Schema Information
#
# Table name: facilities
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string(255)
#  status     :integer          default("idle"), not null
#

require 'rails_helper'

RSpec.describe Facility, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
