FactoryGirl.define do
  factory :author do
    books { [create(:book), create(:book)] }

    after(:create) do |author|
      create(:creator, creatorable: author)
      author.books.each { |book| book.update(authors: [author] ) }
    end
  end
end
