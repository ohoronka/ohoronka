class TelegramService
  def receive(message)

  end

  def bot
    @bot ||= Telegram.bot
  end
end