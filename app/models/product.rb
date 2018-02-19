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

class Product < ApplicationRecord
  has_many :order_products, dependent: :restrict_with_exception
end
