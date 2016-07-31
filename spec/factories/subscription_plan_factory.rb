FactoryGirl.define do
  factory :subscription_plan do
    trait :with_costs do
      subscription_costs { build_list(:subscription_cost, 3) }
    end
  end
end
