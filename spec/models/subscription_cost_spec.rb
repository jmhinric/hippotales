require 'rails_helper'

RSpec.describe SubscriptionCost, type: :model do
  it { is_expected.to validate_presence_of(:one_month) }
  it { is_expected.to validate_presence_of(:three_month) }
  it { is_expected.to validate_presence_of(:six_month) }
  it { is_expected.to have_many :subscriptions }

  describe ".current" do
    let(:subject) { described_class.current }

    let!(:cost1) do
      create(
        :subscription_cost,
        one_month: 29.99,
        three_month: 27.99,
        six_month: 25.99,
        created_at: Date.new(2016, 1, 15)
      )
    end
    let!(:cost2) do
      create(
        :subscription_cost,
        one_month: 19.99,
        three_month: 17.99,
        six_month: 15.99,
        created_at: Date.new(2016, 1, 20)
      )
    end

    specify { expect(subject.one_month).to eq(19.99) }
    specify { expect(subject.three_month).to eq(17.99) }
    specify { expect(subject.six_month).to eq(15.99) }
  end
end
