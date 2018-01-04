class MobileDevicesController < ApplicationController
  def set_for_user
    MobileDevice.set_for_user(token: params[:token], user: current_user)
    render json: {ok: true}
  end
end
