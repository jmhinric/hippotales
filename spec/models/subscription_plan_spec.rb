require 'rails_helper'

RSpec.describe SubscriptionPlan, type: :model do
  let!(:plan) { create(:subscription_plan, :with_costs, created_at: Date.new(2016, 1, 13)) }

  describe '.current' do
    let!(:plan2) { create(:subscription_plan, created_at: Date.new(2016, 1, 20)) }

    it 'returns the most recently created plan' do
      expect(described_class.current).to eq(plan2)
    end
  end

  describe '#subscription_costs' do
    it 'returns the subscription costs of the plan' do
      expect(plan.subscription_costs.length).to eq(3)
    end
  end
end
