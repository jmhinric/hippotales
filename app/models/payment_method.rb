# == Schema Information
#
# Table name: payment_methods
#
#  id               :uuid             not null, primary key
#  customer_id      :uuid
#  active           :boolean          default(TRUE)
#  email            :string
#  image_url        :string
#  payment_method   :integer
#  card_type        :string
#  cardholder_name  :string
#  token            :string
#  expiration_month :string
#  expiration_year  :string
#  last_4           :string
#

# This class stores a Braintree::PaymentMethod

# Braintree::CreditCard attrs: :card_type, :cardholder_name, :expiration_month,
#   :expiration_year, :last_4
# Braintree::PayPalAccount attrs: :email
# Both: :customer_id, :image_url, :payment_method, :token, :active
class PaymentMethod < ActiveRecord::Base
  validates :token, :payment_method, presence: true

  belongs_to :customer
  has_many :subscriptions

  delegate :braintree_customer_id, to: :customer

  enum payment_method: [:credit_card, :paypal]
end
