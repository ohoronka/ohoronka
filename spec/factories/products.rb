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

FactoryBot.define do
  factory :product do
    image { File.open('spec/fixtures/device.png') }
    sequence(:name) {|n| "product name#{n}" }
    price { 9.99 }
  end
end
