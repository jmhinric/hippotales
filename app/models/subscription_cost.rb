# == Schema Information
#
# Table name: subscription_costs
#
#  id          :uuid             not null, primary key
#  one_month   :decimal(, )
#  three_month :decimal(, )
#  six_month   :decimal(, )
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class SubscriptionCost < ActiveRecord::Base
  validates :one_month, :three_month, :six_month, presence: true
  has_many :subscriptions

  scope :current, -> { order(:created_at).last }
end
