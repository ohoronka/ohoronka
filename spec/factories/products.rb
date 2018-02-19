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

FactoryGirl.define do
  factory :product do
    image 'https://i1.rozetka.ua/goods/2535341/huawei_p_smart_blue_images_2535341215.jpg'
    sequence(:name) {|n| "product name#{n}" }
    price 9.99
  end
end
