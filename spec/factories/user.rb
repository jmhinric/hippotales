FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    password { "password" }
    phone { "#{random_digits(3)}-#{random_digits(3)}-#{random_digits(4)}" }
    address_line1 { Faker::Address.street_address }
    address_line2 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
  end
end

def random_digits(n)
  digits = ''
  n.times { |_i| digits += (0..9).to_a.sample.to_s }
  digits
end
