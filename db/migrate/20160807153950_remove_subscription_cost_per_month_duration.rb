class RemoveSubscriptionCostPerMonthDuration < ActiveRecord::Migration
  def up
    remove_column :subscriptions, :cost_per_month
    remove_column :subscriptions, :duration
  end

  def down
    add_column :subscriptions, :cost_per_month, :decimal
    add_column :subscriptions, :duration, :integer
  end
end
