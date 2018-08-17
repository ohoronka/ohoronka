class Admin::DevicesController < Admin::ApplicationController
  def labels
    @devices = Device.order(:number)
    render layout: 'empty'
  end
end
