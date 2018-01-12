class SensorsController < ApplicationController
  before_action :set_sensor, only: [:edit, :update, :destroy]

  def index
    @sensors = facility.sensors.includes(:device).page(params[:page])
  end

  def new
    @sensor = Sensor.new
  end

  def create
    @sensor = Sensor.new(sensor_params)
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
    flash[:notice] = t('msg.destroyed')
    redirect_to action: :index, facility_id: @sensor.device.facility_id
  end

  private

  helper_method def facility
    @facility ||= current_user.facilities.owned.find(params[:facility_id])
  end

  def sensor_params
    p = params.require(:sensor).permit(:name, :device_id, :gpio_listen, :gpio_ok, :gpio_pull)
    p[:gpio_ok] = p[:gpio_listen] if p[:gpio_listen]
    raise ActiveRecord::RecordNotFound unless facility.devices.ids.include?(p[:device_id].to_i)
    p
  end

  def set_sensor
    @sensor = facility.sensors.find(params[:id])
  end
end
