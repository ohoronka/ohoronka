class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'sidebar_dashboard'

  protected

  def current_user
    @current_user ||= User.take # TODO add authorization
  end
end
