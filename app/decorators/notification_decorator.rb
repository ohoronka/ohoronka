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

  def facility_share_message
    sharer = User.find(object.params['initiator']).decorate
    "#{sharer.full_name} shared facility with you."
    h.t('notification.facility_share', name: sharer.full_name)
  end

  def facility_share_url
    h.facilities_path
  end
end
