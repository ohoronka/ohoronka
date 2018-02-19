class OrdersController < ApplicationController
  before_action :order, only: [:show]

  def index
    @orders = @current_user.orders.no_cart
  end

  def show
  end

  private

  def order
    @order ||= current_user.orders.find(params[:id]).decorate
  end
end
