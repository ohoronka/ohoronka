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

ActiveRecord::Schema.define(version: 20170830094853) do

  create_table "channels", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.string "type"
    t.string "auth_token"
    t.string "identifier"
    t.boolean "activated", default: false
    t.index ["user_id"], name: "index_channels_on_user_id"
  end

  create_table "devices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "pinged_at"
    t.bigint "facility_id"
    t.string "name"
    t.integer "status", default: 6, null: false
    t.integer "gpio_listen", default: 0, null: false
    t.integer "gpio_pull", default: 0, null: false
    t.integer "gpio_ok", default: 0, null: false
    t.index ["facility_id"], name: "index_devices_on_facility_id"
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "target_type"
    t.bigint "target_id"
    t.bigint "facility_id"
    t.integer "target_status", default: 0, null: false
    t.integer "facility_status", default: 0, null: false
    t.index ["facility_id"], name: "index_events_on_facility_id"
    t.index ["target_type", "target_id"], name: "index_events_on_target_type_and_target_id"
  end

  create_table "facilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "status", default: 1, null: false
  end

  create_table "facility_shares", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "facility_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["facility_id"], name: "index_facility_shares_on_facility_id"
    t.index ["user_id", "facility_id"], name: "index_facility_shares_on_user_id_and_facility_id", unique: true
    t.index ["user_id"], name: "index_facility_shares_on_user_id"
  end

  create_table "friendships", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "friend_id"
    t.integer "status", default: 0
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "sensors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "device_id"
    t.string "name"
    t.integer "status", default: 6, null: false
    t.integer "gpio_listen", default: 0, null: false
    t.integer "gpio_pull", default: 0, null: false
    t.integer "gpio_ok", default: 0, null: false
    t.index ["device_id"], name: "index_sensors_on_device_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "about"
    t.string "avatar"
    t.string "background"
  end

  add_foreign_key "channels", "users"
  add_foreign_key "facility_shares", "facilities"
  add_foreign_key "facility_shares", "users"
  add_foreign_key "friendships", "users"
end
