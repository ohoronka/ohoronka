# == Schema Information
#
# Table name: orders
#
#  id               :uuid             not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :uuid             not null
#  number           :integer          not null
#  status           :integer          default("cart"), not null
#  delivery_method  :integer          default("nova_poshta"), not null
#  payment_method   :integer          default("liqpay"), not null
#  total            :decimal(8, 2)
#  paid             :boolean          default(FALSE), not null
#  comment          :text
#  delivery_options :json
#

class Order < ApplicationRecord
  ENABLED_PAYMENT_METHODS = [:on_receipt]

  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  has_many :payment_callbacks, dependent: :destroy
  belongs_to :user

  enum status: {cart: 0, pending: 1}
  enum delivery_method: {nova_poshta: 0}
  enum payment_method: {liqpay: 0, on_receipt: 1}

  before_save :set_delivery_options

  scope :no_cart, ->{ where.not(status: :cart) }

  attr_accessor :validate_delivery
  validate :delivery_validator, if: ->{ validate_delivery }

  def delivery
    delivery_for(delivery_method)
  end

  def delivery_for(method)
    @delivery ||= {}
    @delivery[method] ||= begin
      klass = "::Order::Delivery::#{delivery_method.camelize}".constantize
      klass.new(delivery_options&.slice(*klass::ATTRIBUTES.map(&:to_s)) || {})
    end
  end

  def delivery_attributes=(attr)
    delivery.assign_attributes(attr)
  end

  module Delivery
    class NovaPoshta
      include ActiveModel::Model

      ATTRIBUTES = [:full_name, :phone, :email, :city, :city_ref, :warehouse_ref]

      attr_accessor *ATTRIBUTES

      def as_json
        ATTRIBUTES.map {|a| [a, send(a)]}.to_h
      end

      validates :full_name, presence: true
      validates :phone, presence: true, format: { with: /\A\d{10}\z/}
      validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}
      validates :city, presence: true
      validates :warehouse_ref, presence: true

      def client
        @client ||= NovaPoshtaService.new
      end

      def warehouse
        client.warehouses(city_ref).find{|w| w['Ref'] == warehouse_ref} if city_ref
      end
    end
  end

  private

  def delivery_validator
    errors.add(:delivery, 'Delivery is invalid') if delivery.invalid?
  end

  def set_delivery_options
    self.delivery_options = delivery.as_json
  end
end
