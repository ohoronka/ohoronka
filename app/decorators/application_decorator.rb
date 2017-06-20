class ApplicationDecorator < Draper::Decorator
  CSS_STATUSES = {
    'idle' => 'default',
    'protected' => 'success',
    'alarm' => 'danger',
    'online' => 'success',
    'offline' => 'danger',
    'ok' => 'success',
    'alarm' => 'danger'
  }

  # Define methods for all decorated objects.
  # Helpers are accessed through `helpers` (aka `h`). For example:
  #
  #   def percent_amount
  #     h.number_to_percentage object.amount, precision: 2
  #   end

  def css_status(status = nil)
    CSS_STATUSES[status || object.status]
  end

  def css_next_status
    CSS_STATUSES[object.next_status]
  end
end
