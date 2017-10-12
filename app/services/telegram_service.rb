class TelegramService

  def process_data(data)
    message = parse(data)
    process(message)
  end

  def parse(data)
    @message ||= begin
      update = Telegram::Bot::Types::Update.new(data)
      bot.send(:extract_message, update)
    end
  end

  def process(message)
    case message
    when Telegram::Bot::Types::CallbackQuery
      # Here you can handle your callbacks from inline buttons
      params = JSON.parse(message.data).with_indifferent_access
      case params[:method]
      when 'disable_alarm'
        channel = ::Channel::Telegram.find_by(identifier: message.from.id)
        channel.user.facilities.find(params[:facility_id]).disable_alarm
        channel.notify('Alarm was disabled')
      end
    when Telegram::Bot::Types::Message
      case message.text
      when /\/start (\S+)/
        # start with token
        token = message.text.match(/\/start (\S+)/)[1]
        channel = Channel::Telegram.find_by(auth_token: token)
        if channel
          channel.update(identifier: message.chat.id, activated: true)
          channel.notify("Hey #{channel.user.decorate.full_name}! You have configured the Telegram Notification Channel")
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

  def bot
    @bot ||= Telegram.bot
  end
end