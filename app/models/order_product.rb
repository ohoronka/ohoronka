# == Schema Information
#
# Table name: order_products
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer          not null
#  product_id :integer          not null
#  price      :decimal(8, 2)    default(0.0), not null
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
