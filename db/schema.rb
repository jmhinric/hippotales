# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160304041611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "authors", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors_books", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "book_id"
    t.uuid     "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "title"
    t.string   "isbn"
    t.string   "image"
    t.text     "description"
    t.integer  "age"
    t.integer  "gender",       default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.uuid     "publisher_id"
  end

  create_table "books_illustrators", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "book_id"
    t.uuid     "illustrator_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "children", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.integer  "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "children_subscriptions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid "child_id"
    t.uuid "subscription_id"
  end

  create_table "contact_comments", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.boolean  "replied",    default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "creators", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.uuid     "author_id"
    t.uuid     "illustrator_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "customers", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string "braintree_customer_id"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.uuid   "user_id"
  end

  create_table "illustrators", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_methods", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid    "customer_id"
    t.boolean "active",           default: true
    t.string  "email"
    t.string  "image_url"
    t.integer "payment_method"
    t.string  "card_type"
    t.string  "cardholder_name"
    t.string  "token"
    t.string  "expiration_month"
    t.string  "expiration_year"
    t.string  "last_4"
  end

  create_table "publishers", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscription_costs", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.decimal  "one_month"
    t.decimal  "three_month"
    t.decimal  "six_month"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "subscriptions", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "duration"
    t.decimal  "cost_per_month"
    t.boolean  "is_gift",              default: false
    t.text     "gift_message"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.uuid     "user_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.uuid     "subscription_cost_id"
    t.boolean  "active",               default: true
    t.integer  "status",               default: 0
    t.uuid     "payment_method_id"
  end

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "password_digest"
    t.boolean  "is_admin",        default: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "books", "publishers", name: "fk_books_publishers_publisher_id"
  add_foreign_key "customers", "users"
  add_foreign_key "payment_methods", "customers"
  add_foreign_key "subscriptions", "payment_methods"
  add_foreign_key "subscriptions", "users"
end
