class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def to_cart
    current_user.cart_service.add(product)
    flash[:notice] = t('msg.created')
    redirect_to cart_path
  end

  private

  def product
    @product ||= Product.find(params[:id])
  end
end
