class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: :uuid do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :address_line1
      t.string :address_line2
      t.string :city
      t.string :state
      t.string :zip
      t.string :password_digest
      t.boolean :is_admin, default: false

      t.timestamps null: false
    end

    add_index :users, :email, :unique => true
  end
end
