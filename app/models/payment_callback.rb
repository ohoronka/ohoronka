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

class PaymentCallback < ApplicationRecord
  belongs_to :order
end
