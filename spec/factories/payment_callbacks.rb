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

FactoryBot.define do
  factory :payment_callback do
    order nil
    options ""
  end
end
