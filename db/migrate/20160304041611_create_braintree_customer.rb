class CreateBraintreeCustomer < ActiveRecord::Migration
  def change
    create_table :customers, id: :uuid do |t|
      t.string :braintree_customer_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.uuid :user_id
    end

    create_table :payment_methods, id: :uuid do |t|
      t.uuid :customer_id
      t.boolean :active, default: true
      t.string :email
      t.string :image_url
      t.integer :payment_method
      t.string :card_type
      t.string :cardholder_name
      t.string :token
      t.string :expiration_month
      t.string :expiration_year
      t.string :last_4
    end

    add_foreign_key :payment_methods, :customers
    add_foreign_key :customers, :users

    add_column :subscriptions, :payment_method_id, :uuid
    add_foreign_key :subscriptions, :payment_methods
  end
end
