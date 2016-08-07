# == Schema Information
#
# Table name: subscriptions
#
#  id                   :uuid             not null, primary key
#  is_gift              :boolean          default(FALSE)
#  gift_message         :text
#  address_line1        :string
#  address_line2        :string
#  city                 :string
#  state                :string
#  zip                  :string
#  user_id              :uuid
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  subscription_cost_id :uuid
#  active               :boolean          default(TRUE)
#  status               :integer          default(0)
#  payment_method_id    :uuid
#

class Subscription < ActiveRecord::Base
  include TextUtils

  belongs_to :user, required: true
  belongs_to :subscription_cost, required: true
  belongs_to :payment_method
  has_and_belongs_to_many :children
  validates :address_line1, :city, :state, :zip, presence: true

  delegate :cost, :duration, to: :subscription_cost
  delegate :customer, to: :user
  delegate :braintree_customer_id, to: :payment_method
  delegate :token, to: :payment_method

  alias :payment_token :token
  alias :cost_per_month :cost

  enum status: [:waiting, :queued, :shipped, :finalized]

  before_save :capitalize_fields

  def child_names
    and_join(children.map(&:display_name))
  end

  def payment_token
    payment_method.token
  end

  # Creates a json form of the model with selected fields
  def self.as_new
    new.as_json(except: [
      :id,
      :created_at,
      :updated_at,
      :active,
      :status,
      :payment_method_id,
      :user_id
    ])
  end

  private

  def capitalize_fields
    capitalize_attrs([:address_line1, :address_line2, :city])
  end
end
