# == Schema Information
#
# Table name: payment_callbacks
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer
#  status     :string
#  options    :json
#

require 'rails_helper'

RSpec.describe PaymentCallback, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
