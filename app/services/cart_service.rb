class CartService
  include Rails.application.routes.url_helpers

  attr_accessor :cart

  def initialize(cart:)
    @cart = cart
  end

  def add(product)
    Order.transaction do
      order_product = cart.order_products.find_or_initialize_by(product_id: product.id) do |op|
        op.price = product.price
        op.quantity = 0
      end
      order_product.quantity += 1
      order_product.save

      calculate_total
      cart.save!
    end
  end

  def update_item(item, params)
    Order.transaction do
      item.update!(params)
      calculate_total
      cart.save!
    end
  end

  def remove_item(order_product_id)
    Order.transaction do
      cart.order_products.find(order_product_id).destroy
      calculate_total
      cart.save!
    end
  end

  def checkout(params)
    cart.validate_delivery = true
    cart.update!(params.merge(status: :pending, created_at: Time.current))
    OrderMailer.checkout_email(cart).deliver_later

    kb = [
      ::Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Go to order', url: admin_order_url(cart)),
    ]
    markup = ::Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
    User.where(admin: true).each do |user|
      user.channels.telegram.each do |telegram|
        telegram.notify("New order has been added", reply_markup: markup)
      end
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  def calculate_total
    cart.total = cart.order_products.reload.sum{|op| op.price * op.quantity}
  end
end
