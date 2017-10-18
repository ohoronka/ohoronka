class EventDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       facility.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def css_target_status
    css_status(object.target_status)
  end

  def target_status
    human_enum(:target_status)
  end
end
