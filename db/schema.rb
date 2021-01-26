# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_26_085113) do

  create_table "buyer_locations", force: :cascade do |t|
    t.float "longitude"
    t.float "latitude"
    t.string "name"
    t.integer "buyer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_buyer_locations_on_buyer_id"
  end

  create_table "buyers", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.boolean "is_verified"
    t.integer "verification_code"
    t.index ["confirmation_token"], name: "index_buyers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_buyers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_buyers_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_buyers_on_uid_and_provider", unique: true
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer "quantity"
    t.integer "buyer_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_cart_items_on_buyer_id"
    t.index ["product_id"], name: "index_cart_items_on_product_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "buyer_id", null: false
    t.integer "seller_id", null: false
    t.integer "checkout_order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_carts_on_buyer_id"
    t.index ["seller_id"], name: "index_carts_on_seller_id"
  end

  create_table "checkout_orders", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "checkout_products", force: :cascade do |t|
    t.integer "product_id", null: false
    t.integer "checkout_order_id", null: false
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["checkout_order_id"], name: "index_checkout_products_on_checkout_order_id"
    t.index ["product_id"], name: "index_checkout_products_on_product_id"
  end

  create_table "completed_transactions", force: :cascade do |t|
    t.datetime "date"
    t.integer "rider_id", null: false
    t.integer "buyer_location_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "buyer_id", null: false
    t.integer "seller_id", null: false
    t.integer "checkout_order_id"
    t.index ["buyer_id"], name: "index_completed_transactions_on_buyer_id"
    t.index ["buyer_location_id"], name: "index_completed_transactions_on_buyer_location_id"
    t.index ["rider_id"], name: "index_completed_transactions_on_rider_id"
    t.index ["seller_id"], name: "index_completed_transactions_on_seller_id"
  end

  create_table "current_transactions", force: :cascade do |t|
    t.string "status"
    t.integer "time_remaining"
    t.boolean "is_paid"
    t.integer "buyer_id", null: false
    t.integer "rider_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "buyer_location_id", null: false
    t.integer "seller_id", null: false
    t.integer "checkout_order_id"
    t.index ["buyer_id"], name: "index_current_transactions_on_buyer_id"
    t.index ["buyer_location_id"], name: "index_current_transactions_on_buyer_location_id"
    t.index ["rider_id"], name: "index_current_transactions_on_rider_id"
    t.index ["seller_id"], name: "index_current_transactions_on_seller_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.integer "seller_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["seller_id"], name: "index_product_categories_on_seller_id"
  end

  create_table "products", force: :cascade do |t|
    t.integer "product_category_id", null: false
    t.string "name"
    t.integer "price"
    t.integer "discount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_category_id"], name: "index_products_on_product_category_id"
  end

  create_table "riders", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "is_verified"
    t.string "phone_number"
    t.integer "verification_code"
    t.string "address"
    t.string "plate_number"
    t.index ["confirmation_token"], name: "index_riders_on_confirmation_token", unique: true
    t.index ["email"], name: "index_riders_on_email", unique: true
    t.index ["reset_password_token"], name: "index_riders_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_riders_on_uid_and_provider", unique: true
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "seller_id", null: false
    t.string "monday"
    t.string "tuesday"
    t.string "wednesday"
    t.string "thursday"
    t.string "friday"
    t.string "saturday"
    t.string "sunday"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["seller_id"], name: "index_schedules_on_seller_id"
  end

  create_table "seller_users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_seller_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_seller_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_seller_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_seller_users_on_uid_and_provider", unique: true
  end

  create_table "sellers", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone_number"
    t.boolean "is_verified"
    t.float "longitude"
    t.float "latitude"
    t.integer "verification_code"
    t.string "category"
    t.string "company_name"
    t.string "location"
    t.index ["confirmation_token"], name: "index_sellers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_sellers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_sellers_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_sellers_on_uid_and_provider", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.integer "seller_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["seller_id"], name: "index_tags_on_seller_id"
  end

  add_foreign_key "buyer_locations", "buyers"
  add_foreign_key "cart_items", "buyers"
  add_foreign_key "cart_items", "products"
  add_foreign_key "carts", "buyers"
  add_foreign_key "carts", "sellers"
  add_foreign_key "checkout_products", "checkout_orders"
  add_foreign_key "checkout_products", "products"
  add_foreign_key "completed_transactions", "buyer_locations"
  add_foreign_key "completed_transactions", "buyers"
  add_foreign_key "completed_transactions", "riders"
  add_foreign_key "completed_transactions", "sellers"
  add_foreign_key "current_transactions", "buyer_locations"
  add_foreign_key "current_transactions", "buyers"
  add_foreign_key "current_transactions", "riders"
  add_foreign_key "current_transactions", "sellers"
  add_foreign_key "product_categories", "sellers"
  add_foreign_key "products", "product_categories"
  add_foreign_key "schedules", "sellers"
  add_foreign_key "tags", "sellers"
end
