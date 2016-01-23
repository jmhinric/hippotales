class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.integer :gender

      t.timestamps null: false
    end
  end

  create_table :children_subscriptions, id: :uuid do |t|
    t.uuid :child_id
    t.uuid :subscription_id
  end
end
