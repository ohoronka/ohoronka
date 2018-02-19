class OrderMailer < ApplicationMailer
  def checkout_email(order)
    @order = order.decorate
    mail(to: @order.user.decorate.mail_to, subject: "Order ##{@order.number}")
  end
end
