class BotsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :verify_authenticity_token

  def telegram
    raise ActionController::RoutingError.new('Not Found') unless params[:bot_token] == Telegram::CONFIG[:token]
    TelegramService.new.process_data(params.permit!)
    render plain: 'ok'
  end
end
