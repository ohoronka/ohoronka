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

  def url
    "https://telegram.me/#{::Telegram::CONFIG[:bot_name]}?start=#{auth_token}"
  end

  private

  def set_auth_token
    self.auth_token = SecureRandom.urlsafe_base64
  end
end
