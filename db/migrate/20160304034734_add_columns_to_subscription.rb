class AddColumnsToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :active, :boolean, default: true
    add_column :subscriptions, :status, :integer, default: 0

    add_foreign_key :subscriptions, :users
  end
end
