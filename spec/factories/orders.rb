# == Schema Information
#
# Table name: orders
#
#  id               :integer          not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer          not null
#  number           :integer          not null
#  status           :integer          default("cart"), not null
#  delivery_method  :integer          default("nova_poshta"), not null
#  payment_method   :integer          default("liqpay"), not null
#  total            :decimal(8, 2)    default(0.0), not null
#  paid             :boolean          default(FALSE), not null
#  comment          :text
#  delivery_options :json
#

FactoryBot.define do
  factory :order do
    
  end
end
