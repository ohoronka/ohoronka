# Preview all emails at http://localhost:3000/rails/mailers/order
class OrderPreview < ActionMailer::Preview
  def checkout_email
    OrderMailer.checkout_email(Order.no_cart.first)
  end
end
