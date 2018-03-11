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

class Channel < ApplicationRecord
  belongs_to :user

  SUB_CLASSES = [Telegram]
end

require (Rails.root + 'app/models/channel/telegram')
