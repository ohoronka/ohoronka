service = TelegramService.new

Telegram.bot.run do |bot|
  bot.listen do |message|
    service.process(message)
  end
end
