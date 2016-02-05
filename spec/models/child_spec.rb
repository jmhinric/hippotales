require 'rails_helper'

RSpec.describe Child, type: :model do
  [:first_name, :last_name, :birthday, :gender].each do |attr|
    it { should validate_presence_of(attr) }
  end
  it { should validate_uniqueness_of(:last_name).scoped_to([:first_name, :birthday]) }
  it { should have_and_belong_to_many :subscriptions }

  let(:child) { create :child }
  let(:subscription) { create :subscription }

  before { child.update!(subscriptions: [subscription]) }

  it "has subscriptions" do
    expect(child.subscriptions).to be
  end

  describe "#gender" do
    it "has gender 'boy' for value 0" do
      child.update!(gender: 0)
      expect(child.gender).to eq("boy")
    end

    it "has gender 'girl' for value 1" do
      child.update!(gender: 1)
      expect(child.gender).to eq("girl")
    end
  end
end
