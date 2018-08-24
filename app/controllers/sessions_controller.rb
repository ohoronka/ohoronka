class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  before_action :redirect_if_signed_in, except: [:destroy, :change_version]
  layout 'sign_up'

  def new
    @session = SessionService.new
  end

  def create
    @session = SessionService.new(session_params)
    if @session.sign_in(self)
      redirect_to root_path
    else
      render action: :new
    end
  end

  def destroy
    if params[:mobile_token]
      current_user.mobile_devices.find_by(token: params[:mobile_token]).destroy
    end
    cookies.delete(:auth_token)
    reset_session
    redirect_to sign_in_path
  end

  def change_version
    if mobile?
      session[:full_version] = true
    else
      session[:full_version] = false
    end
    redirect_back(fallback_location: root_path)
  end

  private

  def redirect_if_signed_in
    redirect_to root_path if current_user
  end

  def session_params
    params.require(:session).permit(:user_name, :password)
  end
end
