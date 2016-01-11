FactoryGirl.define do
  factory :book do
    title { Faker::Book.title }
    isbn { Faker::Code.isbn }
    image "book_image.jpg"
    description { Faker::Lorem.paragraph(3) }
    age 0
    gender 0
    publisher { build :publisher }
  end
end
