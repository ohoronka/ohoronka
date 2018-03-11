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

class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, numericality: {greater_than_or_equal_to: 1}

  def subtotal
    quantity * price
  end
end
