class DevicesController < ApplicationController
  before_action :device, only: [:edit]

  def index
    @devices = current_user.devices
  end

  def edit

  end

  def update
    if device.update(device_params)
      redirect_to({action: :index}, notice: t('msg.updated'))
    else
      render :edit
    end
  end

  private

  def device
    @device ||= current_user.devices.find(params[:id])
  end

  def device_params
    params.require(:device).permit(:name, :facility_id)
  end
end
