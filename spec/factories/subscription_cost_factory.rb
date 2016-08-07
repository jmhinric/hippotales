FactoryGirl.define do
  factory :subscription_cost do
    cost { Faker::Number.decimal(2) }
    duration { (1..12).to_a.sample }
  end
end
