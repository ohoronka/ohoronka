class Admin::OrdersController < Admin::ApplicationController
  before_action :order, only: [:show]

  def index
    @grid = OrdersGrid.new(grid_params) do |scope|
      scope.page(params[:page])
    end
  end

  def show
    render 'orders/show'
  end

  protected

  def order
    @order ||= Order.find(params[:id]).decorate
  end

  def grid_params
    params.fetch(:orders_grid, {}).permit!
  end
end
