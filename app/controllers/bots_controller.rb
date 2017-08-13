class BotsController < ApplicationController
  def telegram
    Rails.logger.debug params.inspect
  end
end
