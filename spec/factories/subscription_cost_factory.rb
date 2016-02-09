FactoryGirl.define do
  factory :subscription_cost do
    one_month { Faker::Number }
    three_month { Faker::Number }
    six_month { Faker::Number }
  end
end
