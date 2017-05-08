class AccountChannel < ApplicationCable::Channel
  def subscribed
    stream_from current_user.account
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
