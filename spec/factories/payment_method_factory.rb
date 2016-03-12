FactoryGirl.define do
  factory :payment_method do
    token { SecureRandom.hex(6) }
    payment_method { 0 }
    image_url { Faker::Internet.url }
    active { true }

    trait :paypal do
      email { Faker::Internet.email }
    end

    trait :credit_card do
      card_type { Faker::Business.credit_card_type }
      cardholder_name { Faker::Name.name }
      expiration_month { [1..12].sample.to_s }
      expiration_year { Faker::Date.between(Date.today, 7.years.from_now).strftime("%y") }
      last_4 { Faker::Number.number(4) }
    end
  end
end