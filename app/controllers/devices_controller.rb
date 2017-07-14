class DevicesController < ApplicationController
  before_action :set_device, only: [:edit, :update, :destroy]

  def index
    @devices = object.devices
  end

  def edit

  end

  def update
    if @device.update(device_params)
      redirect_to action: :index, guarded_object_id: @device.object_id
    else
      render action: :edit
    end
  end

  def new
    @device = object.devices.build
  end

  def create
    @device = object.devices.new(device_params)
    if @device.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def destroy
    @device.destroy
    redirect_to action: :index, guarded_object_id: @device.object_id
  end

  private

  def object
    @object ||= current_user.objects.find(params[:guarded_object_id])
  end

  def set_device
    @device = current_user.devices.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:name)
  end
end
