require 'telegram/bot'

class Channel < ApplicationRecord
  belongs_to :user

  class Telegram < Channel
    attribute :chat_id

    typed_store :settings, coder: JSON do |s|
      s.integer :chat_id
    end

    def notify(msg)
      ::Telegram::Bot::Client.run(Rails.application.secrets.telegram_token) do |bot|
        bot.api.send_message(chat_id: chat_id, text: msg)
      end
    end
  end
end
