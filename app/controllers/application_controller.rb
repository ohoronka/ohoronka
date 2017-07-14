class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'general'

  before_action :authorize

  protected

  def authorize
    redirect_to mobile? ? mobile_sign_in_path : sign_in_path unless current_user
  end

  helper_method def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  helper_method def current_admin
    @current_admin ||= User.find_by(id: session[:admin_id])
  end

  def mobile?
    request.user_agent =~ /Mobile|webOS/
  end
end
