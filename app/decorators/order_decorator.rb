class OrderDecorator < ApplicationDecorator
  delegate_all

  decorates_association :user

  def self.payment_methods
    Order.payment_methods.keys.map{|p| [I18n.t("activerecord.attributes.order.payment_methods.#{p}"), p]}
  end

  def payment_method
    I18n.t("activerecord.attributes.order.payment_methods.#{object.payment_method}")
  end

  def delivery_method
    I18n.t("activerecord.attributes.order.delivery_methods.#{object.delivery_method}")
  end

  def payment_form
    return if object.paid?

    if payment_method == 'liqpay'
      liqpay = Liqpay.new

      options = {
        action:      "pay",
        amount:      object.total,
        currency:    "UAH",
        description: "Оплата обладнання",
        order_id:    object.id,
        server_url:  h.payment_liqpay_url,
        result_url:  h.order_path(object.id),
        version:     "3"
      }
      options[:sandbox] = '1' unless Rails.env.production?

      liqpay.cnb_form(options).html_safe
    end
  end

  def number
    "##{object.number}"
  end

  def total
    h.number_to_currency object.total
  end

  def paid?
    object.paid? ? h.t('paid') : h.t('unpaid')
  end
  alias_method :paid, :paid?

end
