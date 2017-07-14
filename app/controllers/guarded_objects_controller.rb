class GuardedObjectsController < ApplicationController
  before_action :set_object, only: [:edit, :update, :destroy, :set_next_status, :show]

  def index
    @objects = current_user.objects
    redirect_to @objects.take if @objects.any?
  end

  def show
    
  end

  def edit

  end

  def update
    if @object.update(object_params)
      redirect_to action: :index
    else
      render action: :edit
    end
  end

  def new
    @object = current_user.account.objects.new
  end

  def create
    @object = current_user.account.objects.new(object_params)
    if @object.save
      redirect_to guarded_objects_path
    else
      render action: :new
    end
  end

  def set_next_status
    @object.update(status: @object.next_status)
    render '_update_object'
  end

  def update_object
    render '_update_object'
  end

  private

  def set_object
    @object = current_user.objects.find(params[:id])
  end

  def object_params
    params.require(:guarded_object).permit(:name)
  end
end
