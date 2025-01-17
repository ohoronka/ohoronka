class ApplicationDecorator < Draper::Decorator
  CSS_STATUSES = {
    'idle' => 'default',
    'protected' => 'success',
    'alarm' => 'danger',
    'online' => 'success',
    'offline' => 'danger',
    'ok' => 'success',
  }

  # Define methods for all decorated facilities.
  # Helpers are accessed through `helpers` (aka `h`). For example:
  #
  #   def percent_amount
  #     h.number_to_percentage facility.amount, precision: 2
  #   end

  def css_status(status = nil)
    CSS_STATUSES[status || object.status]
  end

  def css_next_status
    CSS_STATUSES[object.next_status]
  end

  def status(field: :status)
    human_enum(:status)
  end

  def status_badge(field: :status)
    "<span class=\"badge badge-#{object.send(field)}\">#{status(field: field)}</span>".html_safe
  end

  def human_enum(field = :status)
    I18n.t("enum.#{field}.#{object.send(field)}")
  end
end
