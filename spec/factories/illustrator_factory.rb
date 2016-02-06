FactoryGirl.define do
  factory :illustrator do
    books { [build(:book), build(:book)] }

    after(:create) do |i|
      create(:creator, illustrator_id: i.id)
      i.books.each { |book| book.update(illustrators: [i] ) }
    end
  end
end
