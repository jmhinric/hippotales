FactoryGirl.define do
  factory :subscription do
    duration 1
    is_gift "false"
    gift_message "A gift message"
    cost_per_month "9.99"
    address_line1 { Faker::Address.street_address }
    address_line2 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
    user { create :user }
  end
end
