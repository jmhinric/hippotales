class CreateSubscriptionCosts < ActiveRecord::Migration
  def change
    create_table :subscription_costs, id: :uuid do |t|
      t.decimal :one_month
      t.decimal :three_month
      t.decimal :six_month

      t.timestamps null: false
    end

    add_column :subscriptions, :subscription_cost_id, :uuid
  end
end
