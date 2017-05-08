class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'sidebar_dashboard'
end
