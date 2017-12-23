# == Schema Information
#
# Table name: channels
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#  type       :string
#  auth_token :string
#  identifier :string
#  activated  :boolean          default(FALSE)
#

class Channel < ApplicationRecord
  belongs_to :user

  SUB_CLASSES = [Telegram]
end

require (Rails.root + 'app/models/channel/telegram')
