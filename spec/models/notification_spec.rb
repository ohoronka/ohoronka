# == Schema Information
#
# Table name: notifications
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  target_type :string
#  target_id   :integer
#  event       :integer          default(NULL)
#  unread      :boolean          default(TRUE)
#  params      :string
#

require 'rails_helper'

RSpec.describe Notification, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
