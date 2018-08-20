class TelegramService

  def process_data(data)
    message = parse(data)
    process(message)
  end

  def parse(data)
    @message ||= Telegram::Bot::Types::Update.new(data).current_message
  end

  def process(message)
    case message
    when Telegram::Bot::Types::CallbackQuery
      # Here you can handle your callbacks from inline buttons
      params = JSON.parse(message.data).with_indifferent_access

      case params[:m] # method
        when 'da' # disable_alarm
          channel = ::Channel::Telegram.find_by(identifier: message.from.id)
          facility = channel.user.facilities.find(params[:facility_id])
          facility.alarm_service.disable_alarm(user: channel.user)
      end
    when Telegram::Bot::Types::Message
      case message.text
      when /\/start (\S+)/
        # start with token
        token = message.text.match(/\/start (\S+)/)[1]
        channel = Channel::Telegram.find_by(auth_token: token)
        if channel
          channel.update(identifier: message.chat.id, active: true)
          channel.notify(I18n.t('channel.Telegram.was_configured'))
        else
          # TODO: notify dev
          bot.api.send_message(chat_id: message.chat.id, text: I18n.t('msg.error'))
        end
      when '/start'
        # start without token
        channel = Channel::Telegram.find_by(identifier: message.chat.id)
        if channel
          channel.notify("Hey #{channel.user.name}! How is it going?")
        else
          bot.api.send_message(chat_id: message.chat.id, text: "Hey guy! I've no idea who you are. Please sign up to https://ohoronka.com")
        end
      when '/stop'
        bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
      else
        channel = Channel::Telegram.find_by(identifier: message.chat.id)
        if channel
          channel.notify(I18n.t('channel.Telegram.not_so_smart', name: channel.user.decorate.full_name))
        else
          bot.api.send_message(chat_id: message.chat.id, text: "Hey guy! I've no idea who you are. Please sign up to https://ohoronka.com")
        end
      end
    end
  end

  def bot
    @bot ||= Telegram.bot
  end
end
