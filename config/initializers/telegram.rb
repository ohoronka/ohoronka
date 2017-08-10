require 'telegram/bot'

module Telegram
  CONFIG = YAML.load(ERB.new(File.read(Rails.root.join('config/telegram.yml'))).result)[Rails.env].deep_symbolize_keys

  def self.bot
    ::Telegram::Bot::Client.new(CONFIG[:token], { logger: Rails.logger })
  end
end

Thread.new do
   Telegram.bot.run do |bot|
    bot.listen do |message|
      case message.text
      when /\/start (\w+)/
        # start with token
        token = message.text.match(/\/start (\w+)/)[1]
        channel = Channel::Telegram.find_by(auth_token: token)
        if channel
          channel.update(identifier: message.chat.id, activated: true)
          channel.notify("Hey #{channel.user.name}! You have configured the Telegram Notification Channel")
        else
          # TODO: notify dev
          bot.api.send_message(chat_id: message.chat.id, text: "Hm... I can't connect you to any user account... Some thing went wrong...")
        end
      when '/start'
        # start without token
        channel = Channel::Telegram.find_by(identifier: message.chat.id)
        if channel
          channel.notify("Hey #{channel.user.name}! How is it going?")
        else
          bot.api.send_message(chat_id: message.chat.id, text: "Hey guy! I've no idea who you are. Please sign up to http://ohoronka.com")
        end
      when '/stop'
        bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
      else
        channel = Channel::Telegram.find_by(identifier: message.chat.id)
        if channel
          channel.notify("Hey #{channel.user.name}! I'm not so smart to answer your questions. So ask support guys on http://ohoronka.com/support")
        else
          bot.api.send_message(chat_id: message.chat.id, text: "Hey guy! I've no idea who you are. Please sign up to http://ohoronka.com")
        end
      end
    end
  end
end if Rails.env.production? || ENV['TELEGRAM']
