class SensorsController < ApplicationController
  before_action :set_sensor, only: [:edit, :update, :destroy]
  layout 'facility'

  def index
    @sensors = facility.sensors.includes(:device)
  end

  def new
    @sensor = Sensor.new
  end

  def select_device
    @devices = facility.devices
    redirect_to action: :new, device_id: @devices.take if @devices.count == 1
  end

  def create
    @sensor = device.sensors.new(sensor_params)
    if @sensor.save
      redirect_to action: :index
    else
      render action: :new
    end
  end

  def edit

  end

  def update
    if @sensor.update(sensor_params)
      redirect_to action: :index, facility_id: facility.id
    else
      render action: :edit
    end
  end

  def destroy
    @sensor.destroy
    redirect_to action: :index, facility_id: @sensor.device.facility_id
  end

  private

  helper_method def facility
    @facility ||= current_user.facilities.owned.find(params[:facility_id])
  end

  helper_method def device
    @device ||= facility.devices.find(params[:device_id])
  end

  def sensor_params
    p = params.require(:sensor).permit(:name, :gpio_listen, :gpio_ok, :gpio_pull)
    p[:gpio_ok] = p[:gpio_listen] if p[:gpio_listen]
    p
  end

  def set_sensor
    @sensor = device.sensors.find(params[:id])
  end
end
