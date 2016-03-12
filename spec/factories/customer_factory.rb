FactoryGirl.define do
  factory :customer do
    braintree_customer_id { SecureRandom.hex(10) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
  end
end
