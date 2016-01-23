class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions, id: :uuid do |t|
      t.integer :duration
      t.decimal :cost_per_month
      t.boolean :is_gift, default: false
      t.text :gift_message
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :state
      t.string :zip
      t.uuid :user_id

      t.timestamps null: false
    end
  end
end
