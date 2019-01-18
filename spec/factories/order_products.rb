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

FactoryBot.define do
  factory :order_product do
    order { nil }
    product { nil }
    price { "9.99" }
  end
end
