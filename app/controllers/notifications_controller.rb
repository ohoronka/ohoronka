class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.order(id: :desc).page(params[:page])
  end
end
