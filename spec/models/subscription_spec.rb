require 'rails_helper'

RSpec.describe Subscription, type: :model do
  [:duration, :cost_per_month, :address_line1, :city, :state, :zip].each do |attr|
    it { is_expected.to validate_presence_of(attr) }
  end
  it { is_expected.to belong_to :user }
  it { is_expected.to belong_to :subscription_cost }
  it { is_expected.to belong_to :payment_method }
  it { is_expected.to have_and_belong_to_many :children }
  it { is_expected.to delegate_method(:customer).to(:user) }
  it { is_expected.to delegate_method(:braintree_customer_id).to(:payment_method) }

  let(:subscription) { create :subscription }
  let(:child) { create :child }

  before { subscription.update!(children: [child]) }

  it "has children" do
    expect(subscription.children).to be
  end

  it "has a user" do
    expect(subscription.user).to be
  end
end
