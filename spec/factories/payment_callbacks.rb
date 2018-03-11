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

FactoryBot.define do
  factory :payment_callback do
    order nil
    options ""
  end
end
