class Admin::ProductsController < Admin::ApplicationController
  before_action :product, only: [:edit, :update, :destroy]

  def index
    @products = Product.page(params[:page])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to({action: :index}, notice: t('msg.created'))
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to({action: :index}, notice: t('msg.updated'))
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to({action: :index}, notice: t('msg.destroyed'))
  end

  private

  def product
    @product ||= Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(Product.column_names)
  end

end
