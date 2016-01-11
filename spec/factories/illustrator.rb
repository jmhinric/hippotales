FactoryGirl.define do
  factory :illustrator do
    books { [build(:book), build(:book)] }

    after(:create) do |i|
      create(:creator, creatorable: i)
      i.books.each { |book| book.update(illustrators: [i] ) }
    end
  end
end
