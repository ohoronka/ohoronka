class CartsController < ApplicationController
  before_action :cart

  def show
  end

  def edit
  end

  def update
    if @current_user.cart_service.checkout(cart_params)
      redirect_to order_path(@cart)
    else
      render :edit
    end
  end

  def update_item
    @item = @cart.order_products.find(params[:item_id])
    @current_user.cart_service.update_item(@item, order_product_params)
  end

  def remove_item
    @current_user.cart_service.remove_item(params[:item_id])
    redirect_to({action: :show}, {notice: t('msg.destroyed')})
  end

  def cities
    nova_poshta = NovaPoshtaService.new
    @areas = nova_poshta.areas.map{|a| [a['Ref'], a['Description']]}.to_h
    @cities = nova_poshta.cities_by(description: params[:q])
  end

  def warehouses
    nova_poshta = NovaPoshtaService.new
    @warehouses = nova_poshta.warehouses(params[:city_ref])
    render layout: false
  end

  private

  def cart
    @cart ||= current_user.cart
  end

  def cart_params
    params.require(:order).permit(:delivery_method, :payment_method, :comment, delivery_attributes: {})
  end

  def order_product_params
    params.require(:order_product).permit(:quantity)
  end

end
