# == Schema Information
#
# Table name: payment_callbacks
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :uuid             not null
#  status     :string
#  options    :json
#

require 'rails_helper'

RSpec.describe PaymentCallback, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
