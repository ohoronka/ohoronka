class DashboardEventsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "dashboard_events:#{current_user.facilities.find_by(id: params[:facility_id]).id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
