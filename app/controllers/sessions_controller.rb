class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  before_action :redirect_if_signed_in, except: [:destroy]
  layout 'empty'

  def new
    @session = SessionService.new
  end

  def create
    @session = SessionService.new(session_params)
    if @session.sign_in(self)
      redirect_to mobile? ? mobile_root_path : root_path
    else
      render action: :new
    end
  end

  def destroy
    reset_session
    redirect_to mobile? ? mobile_sign_in_path : sign_in_path
  end

  private

  def redirect_if_signed_in
    redirect_to mobile? ? mobile_root_path : root_path if current_user
  end

  def session_params
    params.require(:session).permit(:user_name, :password)
  end
end
