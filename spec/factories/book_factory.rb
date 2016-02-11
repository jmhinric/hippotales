FactoryGirl.define do
  factory :book do
    sequence(:title) { |n| "#{Faker::Book.title}-#{n}" }
    isbn { Faker::Code.isbn }
    image "book_image.jpg"
    description { Faker::Lorem.paragraph(3) }
    age 0
    gender 0
    publisher { build :publisher }
  end
end
