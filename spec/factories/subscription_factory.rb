FactoryGirl.define do
  factory :subscription do
    is_gift "false"
    gift_message "A gift message"
    address_line1 { Faker::Address.street_address }
    address_line2 { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip { Faker::Address.zip }
    user
    subscription_cost
  end
end
