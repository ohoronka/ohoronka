class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'general'

  before_action :authorize
  before_action :prepare_for_mobile

  protected

  def authorize
    redirect_to sign_in_path unless current_user
  end

  helper_method def current_user
    if session[:user_id].blank?
      @current_user = User.find_by(auth_token: cookies[:auth_token])
      SessionService.new.authorize(@current_user, self) if @current_user
      @current_user
    else
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  helper_method def current_admin
    @current_admin ||= User.find_by(id: session[:admin_id])
  end

  helper_method def mobile?
    @_mobile ||= request.user_agent =~ /Mobile|webOS/
  end

  def prepare_for_mobile
    prepend_view_path Rails.root + 'app' + 'views_mobile' if mobile?
  end
end
