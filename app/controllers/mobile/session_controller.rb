class Mobile::SessionController < ApplicationController
  layout 'mobile'
  before_action :redirect_if_signed_in, except: [:logout]
  skip_before_action :authorize, only: [:sign_in_form, :sign_in]

  def sign_in_form
    @session = SessionService.new
  end

  def sign_in
    @session = SessionService.new(session_params)
    if @session.sign_in(self)
      redirect_to mobile_root_path
    else
      render action: :sign_in_form
    end
  end

  def logout
    SessionService.new.logout(self)
    redirect_to action: :sign_in_form
  end

  private

  def redirect_if_signed_in
    redirect_to mobile_root_path if current_user
  end

  def session_params
    params.require(:session).permit(:user_name, :password)
  end
end
