class AccountChannel < ApplicationCable::Channel
  def subscribed
    stream_from "account:#{current_user.account_id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
