class Admin::ApplicationController < ApplicationController
  before_action :check_admin

  protected

  def check_admin
    raise ActionController::RoutingError.new('Not Found') unless current_admin
  end
end
