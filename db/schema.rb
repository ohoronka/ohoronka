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

ActiveRecord::Schema.define(version: 20180122205823) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "type"
    t.string "auth_token"
    t.string "identifier"
    t.boolean "activated", default: false
    t.index ["user_id"], name: "index_channels_on_user_id"
  end

  create_table "devices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "pinged_at"
    t.bigint "facility_id"
    t.string "name"
    t.integer "status", limit: 2, default: 6, null: false
    t.integer "gpio_listen", default: 0, null: false
    t.integer "gpio_pull", default: 0, null: false
    t.integer "gpio_ok", default: 0, null: false
    t.index ["facility_id"], name: "index_devices_on_facility_id"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "target_type"
    t.bigint "target_id"
    t.bigint "facility_id"
    t.integer "target_status", limit: 2, default: 0, null: false
    t.integer "facility_status", limit: 2, default: 0, null: false
    t.index ["facility_id"], name: "index_events_on_facility_id"
    t.index ["target_type", "target_id"], name: "index_events_on_target_type_and_target_id"
  end

  create_table "facilities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "status", limit: 2, default: 1, null: false
  end

  create_table "facility_shares", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "facility_id"
    t.integer "role", limit: 2, default: 0
    t.index ["facility_id"], name: "index_facility_shares_on_facility_id"
    t.index ["user_id", "facility_id"], name: "index_facility_shares_on_user_id_and_facility_id", unique: true
    t.index ["user_id"], name: "index_facility_shares_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "friend_id"
    t.integer "status", limit: 2, default: 0
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "mobile_devices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "token"
    t.index ["user_id"], name: "index_mobile_devices_on_user_id"
  end

  create_table "mqtt_acls", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "mqtt_user_id"
    t.string "user_name"
    t.string "topic"
    t.integer "rw", default: 0
    t.index ["mqtt_user_id"], name: "index_mqtt_acls_on_mqtt_user_id"
    t.index ["user_name", "topic"], name: "index_mqtt_acls_on_user_name_and_topic", unique: true
  end

  create_table "mqtt_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "device_id"
    t.string "user_name"
    t.string "password"
    t.string "password_hash"
    t.index ["device_id"], name: "index_mqtt_users_on_device_id"
    t.index ["user_name"], name: "index_mqtt_users_on_user_name", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "target_type"
    t.bigint "target_id"
    t.integer "event", limit: 2, default: 0
    t.boolean "unread", default: true
    t.string "params"
    t.index ["target_type", "target_id"], name: "index_notifications_on_target_type_and_target_id"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "order_products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id", null: false
    t.bigint "product_id", null: false
    t.decimal "price", precision: 8, scale: 2, default: "0.0", null: false
    t.integer "quantity", default: 1, null: false
    t.index ["order_id"], name: "index_order_products_on_order_id"
    t.index ["product_id"], name: "index_order_products_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "number", default: -> { "nextval('order_number_seq'::regclass)" }, null: false
    t.integer "status", limit: 2, default: 0, null: false
    t.integer "delivery_method", limit: 2, default: 0, null: false
    t.integer "payment_method", limit: 2, default: 0, null: false
    t.decimal "total", precision: 8, scale: 2, default: "0.0", null: false
    t.boolean "paid", default: false, null: false
    t.text "comment"
    t.json "delivery_options"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payment_callbacks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_id"
    t.string "status"
    t.json "options"
    t.index ["order_id"], name: "index_payment_callbacks_on_order_id"
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "description"
    t.string "image"
    t.decimal "price", precision: 8, scale: 2, default: "0.0", null: false
    t.integer "stock", default: 0, null: false
  end

  create_table "sensors", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "device_id"
    t.string "name"
    t.integer "status", limit: 2, default: 6, null: false
    t.integer "gpio_listen", default: 0, null: false
    t.integer "gpio_pull", default: 0, null: false
    t.integer "gpio_ok", default: 0, null: false
    t.index ["device_id"], name: "index_sensors_on_device_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.string "last_name"
    t.text "about"
    t.string "avatar"
    t.string "background"
    t.string "auth_token"
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
  end

  add_foreign_key "channels", "users"
  add_foreign_key "facility_shares", "facilities"
  add_foreign_key "facility_shares", "users"
  add_foreign_key "friendships", "users"
  add_foreign_key "mobile_devices", "users"
  add_foreign_key "mqtt_acls", "mqtt_users"
  add_foreign_key "notifications", "users"
  add_foreign_key "order_products", "orders"
  add_foreign_key "order_products", "products"
  add_foreign_key "orders", "users"
  add_foreign_key "payment_callbacks", "orders"
end
