require 'rails_helper'

RSpec.describe Subscription, type: :model do
  [:duration, :cost_per_month, :address_line1, :city, :state, :zip].each do |attr|
    it { should validate_presence_of(attr) }
  end
  it { should belong_to :user }
  it { should have_and_belong_to_many :children }

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
