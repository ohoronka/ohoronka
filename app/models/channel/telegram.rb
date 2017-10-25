# == Schema Information
#
# Table name: channels
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  type       :string(255)
#  auth_token :string(255)
#  identifier :string(255)
#  activated  :boolean          default(FALSE)
#

class Channel::Telegram < Channel
  before_create :set_auth_token

  def notify(msg)
    ::Telegram.bot.run do |bot|
      bot.api.send_message(chat_id: identifier, text: msg)
    end
  end

  def notify_facility_alarm(facility)
    ::Telegram.bot.run do |bot|
      kb = [
        ::Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Disable', callback_data: {method: :disable_alarm, facility_id: facility.id}.to_json),
        ::Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Details', url: facility_url(facility))
      ]
      puts facility_url(facility)
      markup = ::Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      bot.api.send_message(chat_id: identifier, text: I18n.t('channel.Telegram.alarm', facility: facility.name), reply_markup: markup)
    end
  end

  def url
    "https://telegram.me/#{::Telegram::CONFIG[:bot_name]}?start=#{auth_token}"
  end

  private

  def set_auth_token
    self.auth_token = SecureRandom.urlsafe_base64
  end
end
