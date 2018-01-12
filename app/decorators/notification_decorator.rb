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

  def image_url
    object.user&.decorate&.avatar_url
  end

  def friendship_request_message
    h.t('notification.messages.friend_ship_request', name: object.target.user.decorate.full_name)
  end

  def friendship_request_url
    h.requests_friends_path
  end

  def accepted_friendship_message
    h.t('notification.accepted_friendship', name: object.target.friend.decorate.full_name)
  end

  def accepted_friendship_url
    h.friends_path
  end

  def facility_share_message
    "#{User.find(object.params['initiator']).decorate.full_name} shared facility with you."
    h.t('notification.facility_share', name: User.find(object.params['initiator']).decorate.full_name)
  end

  def facility_share_url
    h.facilities_path
  end
end
