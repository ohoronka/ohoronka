require 'telegram/bot'

class Channel < ApplicationRecord
  belongs_to :user

  class Telegram < Channel
    before_create :set_auth_token

    def notify(msg)
      ::Telegram.bot.run do |bot|
        bot.api.send_message(chat_id: identifier, text: msg)
      end
    end

    def url
      "https://telegram.me/#{::Telegram::CONFIG[:bot_name]}?start=#{auth_token}"
    end

    def set_auth_token
      self.auth_token = SecureRandom.urlsafe_base64
    end
  end
end
