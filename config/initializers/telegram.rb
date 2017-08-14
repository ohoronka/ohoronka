require 'telegram/bot'

module Telegram
  CONFIG = YAML.load(ERB.new(File.read(Rails.root.join('config/telegram.yml'))).result)[Rails.env].deep_symbolize_keys

  def self.bot
    ::Telegram::Bot::Client.new(CONFIG[:token], { logger: Rails.logger })
  end
end
