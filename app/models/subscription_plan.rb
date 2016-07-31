# == Schema Information
#
# Table name: subscription_plans
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class SubscriptionPlan < ActiveRecord::Base
  has_and_belongs_to_many :subscription_costs

  scope :current, -> { order(:created_at).last }
end
