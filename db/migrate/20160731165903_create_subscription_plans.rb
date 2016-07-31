class CreateSubscriptionPlans < ActiveRecord::Migration
  def up
    create_table :subscription_plans, id: :uuid do |t|
      t.timestamps null: false
    end

    add_column :subscription_costs, :cost, :decimal
    add_column :subscription_costs, :duration, :integer

    remove_column :subscription_costs, :one_month
    remove_column :subscription_costs, :three_month
    remove_column :subscription_costs, :six_month
  end

  def down
    drop_table :subscription_plans

    remove_column :subscription_costs, :cost
    remove_column :subscription_costs, :duration

    add_column :subscription_costs, :one_month, :decimal
    add_column :subscription_costs, :three_month, :decimal
    add_column :subscription_costs, :six_month, :decimal
  end
end
