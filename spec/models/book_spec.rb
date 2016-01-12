require 'rails_helper'
require_relative "../support/shared_examples/text_utils_spec"

RSpec.describe Book, type: :model do
  let(:book) { create :book }

  it_behaves_like "text utils"

  it { should validate_presence_of :age }
  it { should validate_presence_of :gender }
  it { should validate_presence_of :title }
  it { should validate_uniqueness_of :title }
  it { should have_and_belong_to_many :authors }
  it { should have_and_belong_to_many :illustrators }
  it { should belong_to :publisher }

  describe "#age" do
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

  describe "#display_author" do
    let(:author1) { create :author }
    let(:author2) { create :author }

    it "gives the name of a single-author book" do
      book.update!(authors: [author1])
      expect(book.display_author).to eq(author1.display_name)
    end

    it "gives the names of a multi-author book" do
      book.update!(authors: [author1, author2])
      expect(book.display_author).to eq(author1.display_name + " and " + author2.display_name)
    end
  end

  describe "#display_illustrator" do
    let(:illustrator1) { create :illustrator }
    let(:illustrator2) { create :illustrator }

    it "gives the name of a single-illustrator book" do
      book.update!(illustrators: [illustrator1])
      expect(book.display_illustrator).to eq(illustrator1.display_name)
    end

    it "gives the names of a multi-illustrator book" do
      book.update!(illustrators: [illustrator1, illustrator2])
      expect(book.display_illustrator).to eq(illustrator1.display_name + " and " + illustrator2.display_name)
    end
  end
end
