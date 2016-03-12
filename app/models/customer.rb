# == Schema Information
#
# Table name: customers
#
#  id                    :uuid             not null, primary key
#  braintree_customer_id :string
#  first_name            :string
#  last_name             :string
#  email                 :string
#  user_id               :uuid
#

# This class stores a Braintree::Customer
class Customer < ActiveRecord::Base
  validates :braintree_customer_id, :first_name, :last_name, :email, presence: true

  has_many :payment_methods
  belongs_to :user
end
