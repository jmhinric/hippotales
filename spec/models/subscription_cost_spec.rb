require 'rails_helper'

RSpec.describe SubscriptionCost, type: :model do
  it { is_expected.to validate_presence_of(:cost) }
  it { is_expected.to validate_presence_of(:duration) }
  it { is_expected.to have_many :subscriptions }

  let(:cost) { build(:subscription_cost, duration: 1, cost: 10.99) }
  let(:cost2) { build(:subscription_cost, duration: 3, cost: 13.99) }
  let(:cost3) { build(:subscription_cost, duration: 16, cost: 13.99) }

  describe '#description' do
    it 'gives the duration in months' do
      expect(cost.description).to eq('1 Month')
      expect(cost2.description).to eq('3 Months')
      expect(cost3.description).to eq('4 Months')
    end
  end

  describe '#per_month' do
    it 'gives a formatted string of the cost per month' do
      expect(cost.per_month).to eq('$10.99 / month')
    end
  end
end
