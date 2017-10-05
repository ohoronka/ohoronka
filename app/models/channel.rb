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

class Channel < ApplicationRecord
  belongs_to :user
end

require (Rails.root + 'app/models/channel/telegram')
