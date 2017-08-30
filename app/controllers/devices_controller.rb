class DevicesController < ApplicationController
  before_action :set_device, only: [:edit, :update, :destroy]
  layout 'facility'

  def index
    @devices = facility.devices
  end

  def edit

  end

  def update
    if @device.update(device_params)
      redirect_to action: :index, facility_id: @device.facility_id
    else
      render action: :edit
    end
  end

  def new
    @device = facility.devices.build
  end

  def create
    @device = facility.devices.new(device_params)
    if @device.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def destroy
    @device.destroy
    redirect_to action: :index, facility_id: @device.facility_id
  end

  private

  helper_method def facility
    @facility ||= current_user.facilities.owned.find(params[:facility_id])
  end

  def set_device
    @device = facility.devices.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:name)
  end
end
