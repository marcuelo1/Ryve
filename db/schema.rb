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

ActiveRecord::Schema.define(version: 2021_02_05_133213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "additionals", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "name"
    t.integer "price"
    t.integer "discount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_additionals_on_product_id"
  end

  create_table "admins", force: :cascade do |t|
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
    t.string "first_name"
    t.string "last_name"
    t.string "nickname"
    t.string "image"
    t.string "email"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_admins_on_uid_and_provider", unique: true
  end

  create_table "buyer_locations", force: :cascade do |t|
    t.float "longitude"
    t.float "latitude"
    t.string "name"
    t.bigint "buyer_id", null: false
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
    t.string "verification_code"
    t.index ["confirmation_token"], name: "index_buyers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_buyers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_buyers_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_buyers_on_uid_and_provider", unique: true
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.bigint "seller_id", null: false
    t.integer "checkout_order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_carts_on_buyer_id"
    t.index ["seller_id"], name: "index_carts_on_seller_id"
  end

  create_table "checkout_additionals", force: :cascade do |t|
    t.bigint "additional_id", null: false
    t.bigint "checkout_product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["additional_id"], name: "index_checkout_additionals_on_additional_id"
    t.index ["checkout_product_id"], name: "index_checkout_additionals_on_checkout_product_id"
  end

  create_table "checkout_orders", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "amount", default: 0
  end

  create_table "checkout_products", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "checkout_order_id", null: false
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["checkout_order_id"], name: "index_checkout_products_on_checkout_order_id"
    t.index ["product_id"], name: "index_checkout_products_on_product_id"
  end

  create_table "checkout_sizes", force: :cascade do |t|
    t.bigint "size_id", null: false
    t.bigint "checkout_product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["checkout_product_id"], name: "index_checkout_sizes_on_checkout_product_id"
    t.index ["size_id"], name: "index_checkout_sizes_on_size_id"
  end

  create_table "completed_transactions", force: :cascade do |t|
    t.datetime "date"
    t.bigint "rider_id", null: false
    t.bigint "buyer_location_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "buyer_id", null: false
    t.bigint "seller_id", null: false
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
    t.bigint "buyer_id", null: false
    t.bigint "rider_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "buyer_location_id", null: false
    t.bigint "seller_id", null: false
    t.integer "checkout_order_id"
    t.index ["buyer_id"], name: "index_current_transactions_on_buyer_id"
    t.index ["buyer_location_id"], name: "index_current_transactions_on_buyer_location_id"
    t.index ["rider_id"], name: "index_current_transactions_on_rider_id"
    t.index ["seller_id"], name: "index_current_transactions_on_seller_id"
  end

  create_table "electricity_providers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "internet_providers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pending_orders", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.bigint "seller_id", null: false
    t.integer "checkout_order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_paid"
    t.bigint "buyer_location_id", null: false
    t.index ["buyer_id"], name: "index_pending_orders_on_buyer_id"
    t.index ["buyer_location_id"], name: "index_pending_orders_on_buyer_location_id"
    t.index ["seller_id"], name: "index_pending_orders_on_seller_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.bigint "seller_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["seller_id"], name: "index_product_categories_on_seller_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "product_category_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_available", default: true
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
    t.string "verification_code"
    t.string "address"
    t.string "plate_number"
    t.index ["confirmation_token"], name: "index_riders_on_confirmation_token", unique: true
    t.index ["email"], name: "index_riders_on_email", unique: true
    t.index ["reset_password_token"], name: "index_riders_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_riders_on_uid_and_provider", unique: true
  end

  create_table "schedules", force: :cascade do |t|
    t.bigint "seller_id", null: false
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
    t.string "verification_code"
    t.string "category"
    t.string "company_name"
    t.string "location"
    t.index ["confirmation_token"], name: "index_sellers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_sellers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_sellers_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_sellers_on_uid_and_provider", unique: true
  end

  create_table "sizes", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "name"
    t.integer "price"
    t.integer "discount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_sizes_on_product_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.bigint "seller_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["seller_id"], name: "index_tags_on_seller_id"
  end

  create_table "utility_completeds", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.bigint "rider_id", null: false
    t.string "bill_number"
    t.string "provider_type", null: false
    t.bigint "provider_id", null: false
    t.datetime "date_transacted"
    t.string "type_of_transaction"
    t.datetime "date_paid"
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_utility_completeds_on_buyer_id"
    t.index ["provider_type", "provider_id"], name: "index_utility_completeds_on_provider_type_and_provider_id"
    t.index ["rider_id"], name: "index_utility_completeds_on_rider_id"
  end

  create_table "utility_currents", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.bigint "rider_id", null: false
    t.string "bill_number"
    t.string "provider_type", null: false
    t.bigint "provider_id", null: false
    t.string "status"
    t.string "type_of_transaction"
    t.boolean "is_paid"
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_utility_currents_on_buyer_id"
    t.index ["provider_type", "provider_id"], name: "index_utility_currents_on_provider_type_and_provider_id"
    t.index ["rider_id"], name: "index_utility_currents_on_rider_id"
  end

  create_table "utility_pendings", force: :cascade do |t|
    t.bigint "buyer_id", null: false
    t.string "bill_number"
    t.string "provider_type", null: false
    t.bigint "provider_id", null: false
    t.string "type_of_transaction"
    t.boolean "is_paid"
    t.integer "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buyer_id"], name: "index_utility_pendings_on_buyer_id"
    t.index ["provider_type", "provider_id"], name: "index_utility_pendings_on_provider_type_and_provider_id"
  end

  create_table "water_providers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "additionals", "products"
  add_foreign_key "buyer_locations", "buyers"
  add_foreign_key "carts", "buyers"
  add_foreign_key "carts", "sellers"
  add_foreign_key "checkout_additionals", "additionals"
  add_foreign_key "checkout_additionals", "checkout_products"
  add_foreign_key "checkout_products", "checkout_orders"
  add_foreign_key "checkout_products", "products"
  add_foreign_key "checkout_sizes", "checkout_products"
  add_foreign_key "checkout_sizes", "sizes"
  add_foreign_key "completed_transactions", "buyer_locations"
  add_foreign_key "completed_transactions", "buyers"
  add_foreign_key "completed_transactions", "riders"
  add_foreign_key "completed_transactions", "sellers"
  add_foreign_key "current_transactions", "buyer_locations"
  add_foreign_key "current_transactions", "buyers"
  add_foreign_key "current_transactions", "riders"
  add_foreign_key "current_transactions", "sellers"
  add_foreign_key "pending_orders", "buyer_locations"
  add_foreign_key "pending_orders", "buyers"
  add_foreign_key "pending_orders", "sellers"
  add_foreign_key "product_categories", "sellers"
  add_foreign_key "products", "product_categories"
  add_foreign_key "schedules", "sellers"
  add_foreign_key "sizes", "products"
  add_foreign_key "tags", "sellers"
  add_foreign_key "utility_completeds", "buyers"
  add_foreign_key "utility_completeds", "riders"
  add_foreign_key "utility_currents", "buyers"
  add_foreign_key "utility_currents", "riders"
  add_foreign_key "utility_pendings", "buyers"
end
