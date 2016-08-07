# == Schema Information
#
# Table name: subscription_costs
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cost       :decimal(, )
#  duration   :integer
#

class SubscriptionCost < ActiveRecord::Base
  has_and_belongs_to_many :subscription_plans
  has_many :subscriptions

  validates :cost, :duration, presence: true
  validates :cost, uniqueness: { scope: :duration }

  def description
    "#{months} #{'Month'.pluralize(months)}"
  end

  def months
    duration % 12
  end

  # cost is per month
  def per_month
    "$#{cost} / month"
  end

  def as_new
    as_json(methods: [:description, :per_month])
  end
end
