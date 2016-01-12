require 'rails_helper'

shared_examples "text utils" do
  let(:model) { described_class.new }

  describe "#and_join" do
    let(:array) { ["first", "second", "third", "fourth"] }

    it "joins single element arrays" do
      expect(model.and_join(["first"])).to eq("first")
    end

    it "joins two element arrays" do
      expect(model.and_join(["first", "second"])).to eq("first and second")
    end

    it "joins multiple element arrays" do
      expect(model.and_join(array)).to eq("first, second, third, and fourth")
    end
  end
end
