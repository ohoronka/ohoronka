# == Schema Information
#
# Table name: channels
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#  type       :string           not null
#  auth_token :string
#  identifier :string
#  active     :boolean          default(FALSE), not null
#

class Channel::Telegram < Channel
  before_create :set_auth_token

  def notify(msg, reply_markup: nil)
    ::Telegram.bot.run do |bot|
      bot.api.send_message(chat_id: identifier, text: msg, reply_markup: reply_markup)
    end
  end

  def notify_facility_alarm(facility)
    ::Telegram.bot.run do |bot|
      kb = [
        ::Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Деталі', url: facility_url(facility)),
        ::Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Вимкнути', callback_data: {m: :da, fid: facility.id}.to_json), # callback_data can be maximum 64 bytes
      ]
      markup = ::Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      bot.api.send_message(chat_id: identifier, text: I18n.t('channel.Telegram.alarm', facility: facility.name), reply_markup: markup)
    end
  end

  def notify_disabled_alarm(facility:)
    ::Telegram.bot.run do |bot|
      bot.api.send_message(chat_id: identifier, text: I18n.t('channel.Telegram.alarm_was_disabled', facility: facility.name))
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
