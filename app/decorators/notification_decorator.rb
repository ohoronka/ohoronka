class NotificationDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def message
    send("#{object.event}_message".to_sym)
  end

  def url
    send("#{object.event}_url".to_sym)
  end

  def friendship_request_message
    "#{object.target.user.decorate.full_name} wants to friend with you."
  end

  def friendship_request_url
    h.requests_friends_path
  end

  def accepted_friendship_message
    "#{object.target.friend.decorate.full_name} accepted friendship."
  end

  def accepted_friendship_url
    h.friends_path
  end

  def facility_share_message
    "#{User.find(object.params['initiator']).decorate.full_name} shared facility with you."
  end

  def facility_share_url
    h.facilities_path
  end
end
