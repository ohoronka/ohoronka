class GuardedObjectDecorator < Draper::Decorator
  CSS_STATUSES = {'idle' => 'default', 'protected' => 'success', 'alarm' => 'danger'}
  delegate_all


  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def css_status
    CSS_STATUSES[object.status]
  end

  def css_next_status
    CSS_STATUSES[object.next_status]
  end

end
