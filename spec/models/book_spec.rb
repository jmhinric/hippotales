require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should validate_presence_of :age }
  it { should validate_presence_of :gender }
  it { should validate_presence_of :title }
  it { should validate_uniqueness_of :title }
  it { should have_and_belong_to_many :authors }
  it { should have_and_belong_to_many :illustrators }
  it { should belong_to :publisher }

  describe "#age" do
    let(:book) { create :book }

    it "has age range 0-1 for value 0" do
      book.update!(age: 0)
      expect(book.age).to eq("0-1")
    end

    it "has age range 1-2 for value 1" do
      book.update!(age: 1)
      expect(book.age).to eq("1-2")
    end

    it "has age range 3-6 for value 0" do
      book.update!(age: 2)
      expect(book.age).to eq("3-6")
    end
  end

  describe "#gender" do
    let(:book) { create :book }

    it "has gender 'both' for value 0" do
      book.update!(gender: 0)
      expect(book.gender).to eq("both")
    end

    it "has gender 'boy' for value 1" do
      book.update!(gender: 1)
      expect(book.gender).to eq("boy")
    end

    it "has gender 'girl' for value 0" do
      book.update!(gender: 2)
      expect(book.gender).to eq("girl")
    end
  end
end
