# == Schema Information
#
# Table name: order_products
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :uuid             not null
#  product_id :uuid             not null
#  price      :decimal(8, 2)
#  quantity   :integer          default(1), not null
#

require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
