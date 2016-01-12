require 'rails_helper'

RSpec.describe Creator, type: :model do
  it { should belong_to :author }
  it { should belong_to :illustrator }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }

  it do
    should validate_uniqueness_of(:last_name)
      .scoped_to(:first_name)
      .case_insensitive
      .with_message "Creator already exists with that first and last name"
  end

  describe "#display_name" do
    let(:creator) do
      create :creator,
        first_name: "Billy",
        middle_name: "Bob",
        last_name: "Thornton"
     end
     let(:result) { creator.display_name }

    it "gives concatenates the first, middle, and last names" do
      expect(result).to eq("Billy Bob Thornton")
    end

    it "gives first and last name if no middle" do
      creator.update!(middle_name: nil)
      expect(result).to eq("Billy Thornton")
    end
  end
end
