class FacilityDevicesController < ApplicationController
  before_action :set_device, only: [:edit, :update, :destroy]

  def index
    @devices = facility.devices.page(params[:page])
  end

  def edit

  end

  def update
    if @device.update(device_params)
      flash[:notice] = t('msg.updated')
      redirect_to action: :index, facility_id: @device.facility_id
    else
      render action: :edit
    end
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
