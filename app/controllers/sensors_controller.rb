class SensorsController < ApplicationController
  before_action :set_sensor, only: [:edit, :update, :destroy]

  def index
    @sensors = object.sensors.includes(:device)
  end

  def new
    @sensor = Sensor.new
  end

  def create
    @sensor = Sensor.new(sensor_params)
    if @sensor.save
      redirect_to action: :index, guarded_object_id: object.id
    else
      render action: :new
    end
  end

  def edit

  end

  def update
    @sensor = Sensor.new(sensor_params)
    if @sensor.save
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

  helper_method def devices
    @devices ||= object.devices
  end

  helper_method def object
    @object ||= current_user.objects.find(params[:guarded_object_id] || set_sensor.device.object_id)
  end

  def sensor_params
    filtered_params = params.require(:sensor).permit(:name, :device_id, :gpio_listen, :gpio_ok, :gpio_pull)
    filtered_params.delete(:device_id) unless devices.ids.include?(filtered_params[:device_id].to_i)
    filtered_params
  end

  def set_sensor
    @sensor = current_user.sensors.find(params[:id])
  end
end
