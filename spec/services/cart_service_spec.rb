require 'rails_helper'

RSpec.describe CartService do
  let(:user) { create(:user) }
  let(:product) { create(:product) }

  describe '#add' do
    it 'adds product to cart' do
      expect{
        user.cart_service.add(product)
      }.to change(user.cart.order_products, :count).by(1)

      item = user.cart.order_products.take
      expect(item.price).to eq(product.price)
      expect(user.cart.total).to eq(product.price)

      expect{
        user.cart_service.add(product)
      }.not_to change(user.cart.order_products, :count)
      user.cart.reload
      expect(user.cart.total).to eq(product.price * 2)
    end
  end
end
