class SensorsController < ApplicationController
  before_action :set_sensor, only: [:edit, :update, :destroy]

  def index
    @sensors = object.sensors.includes(:device)
  end

  def new
    @sensor = Sensor.new
  end

  def select_device
    @devices = object.devices
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
      redirect_to action: :index, guarded_object_id: object.id
    else
      render action: :edit
    end
  end

  def destroy
    @sensor.destroy
    redirect_to action: :index, guarded_object_id: @sensor.device.object_id
  end

  private

  helper_method def object
    @object ||= current_user.objects.find(params[:guarded_object_id])
  end

  helper_method def device
    @device ||= object.devices.find(params[:device_id])
  end

  def sensor_params
    params.require(:sensor).permit(:name, :gpio_listen, :gpio_ok, :gpio_pull) # TODO handle gpio fields
  end

  def set_sensor
    @sensor = device.sensors.find(params[:id])
  end
end
