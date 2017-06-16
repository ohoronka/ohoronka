class Mobile::SessionController < ApplicationController
  layout 'mobile_sign_in'

  before_action :redirect_if_signed_in, except: [:logout]

  def sign_in_form
    @session = SessionService.new
  end

  def sign_in
    if @user = SessionService.new(session_params).sign_in(self)
      redirect_to root_path
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
    redirect_to root_path if current_user
  end

  def session_params
    params.require(:session).permit(:user, :password)
  end
end
