class GuardedObjectChannel < ApplicationCable::Channel
  def subscribed
    stream_from "guarded_object:#{current_user.objects.find_by(id: params[:guarded_object_id]).id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
