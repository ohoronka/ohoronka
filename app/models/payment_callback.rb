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

class PaymentCallback < ApplicationRecord
  belongs_to :order
end
