class GuardedObjectChannel < ApplicationCable::Channel
  def subscribed
    stream_from "guarded_object:#{current_user.objects.first.id}" # TODO fix this
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
