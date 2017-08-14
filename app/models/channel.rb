class Channel < ApplicationRecord
  belongs_to :user
end

require (Rails.root + 'app/models/channel/telegram')