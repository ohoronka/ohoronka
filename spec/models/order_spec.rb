# == Schema Information
#
# Table name: orders
#
#  id               :uuid             not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :uuid             not null
#  number           :integer          not null
#  status           :integer          default("cart"), not null
#  delivery_method  :integer          default("nova_poshta"), not null
#  payment_method   :integer          default("liqpay"), not null
#  total            :decimal(8, 2)
#  paid             :boolean          default(FALSE), not null
#  comment          :text
#  delivery_options :json
#

require 'rails_helper'

RSpec.describe Order, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
