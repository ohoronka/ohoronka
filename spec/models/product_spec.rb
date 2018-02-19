# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string           not null
#  description :string
#  image       :string
#  price       :decimal(8, 2)    default(0.0), not null
#  stock       :integer          default(0), not null
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
