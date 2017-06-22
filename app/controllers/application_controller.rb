class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'sidebar_dashboard'

  before_action :authorize

  protected

  def authorize
    redirect_to mobile_sign_in_path unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
