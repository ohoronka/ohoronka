class Payment::LiqpayController < ApplicationController
  skip_before_action :authorize
  skip_before_action :verify_authenticity_token

  def index
    require 'liqpay'
    liqpay = Liqpay.new
    data      = params[:data]
    signature = params[:signature]

    if liqpay.match?(data, signature)
      options = liqpay.decode_data(data).with_indifferent_access
      order = Order.find(options[:order_id])
      order.payment_callbacks.create!(status: options[:status], options: options)
      order.update!(paid: true) if options[:status] == 'success'
      render json: {ok: true}
    else
      render json: {ok: false}
    end
  end
end
