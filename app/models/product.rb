# == Schema Information
#
# Table name: products
#
#  id          :uuid             not null, primary key
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

  mount_uploader :image, ProductUploader

  validates :name, :image, :price, :stock, presence: true

  validates :price, numericality: {greater_than: 0}
  validates :stock, numericality: {greater_than_or_equal_to: 0}
end
