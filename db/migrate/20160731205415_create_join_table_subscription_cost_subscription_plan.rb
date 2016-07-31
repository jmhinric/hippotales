class CreateJoinTableSubscriptionCostSubscriptionPlan < ActiveRecord::Migration
  def change
    create_table :subscription_costs_plans, id: false do |t|
      t.uuid :subscription_cost_id, null: false
      t.uuid :subscription_plan_id, null: false
    end
  end
end
