FactoryGirl.define do
  factory :child do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthday { Faker::Date.between(6.years.ago, Date.today) }
    gender 1
  end
end
