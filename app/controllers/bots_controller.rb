class BotsController < ApplicationController
  skip_before_action :authorize
  skip_before_action :verify_authenticity_token

  def telegram
    raise ActionController::RoutingError.new('Not Found') unless params[:bot_token] == Telegram::CONFIG[:token]
    TelegramService.new.process_data(telegram_params)
    render plain: 'ok'
  end

  private

  def telegram_params
    params.permit(:update_id, message: {}, session: {})
  end
end
