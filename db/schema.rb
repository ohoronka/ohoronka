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

ActiveRecord::Schema.define(version: 20170620125906) do

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "pinged_at"
    t.bigint "object_id"
    t.string "name"
    t.integer "status", default: 5, null: false
    t.integer "gpio_listen", default: 0, null: false
    t.integer "gpio_pull", default: 0, null: false
    t.integer "gpio_ok", default: 0, null: false
    t.index ["object_id"], name: "index_devices_on_object_id"
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sensor_id"
    t.bigint "object_id"
    t.integer "status", default: 0, null: false
    t.integer "object_status", default: 0, null: false
    t.index ["object_id"], name: "index_events_on_object_id"
    t.index ["sensor_id"], name: "index_events_on_sensor_id"
  end

  create_table "guarded_objects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.string "name"
    t.integer "status", default: 0, null: false
    t.index ["account_id"], name: "index_guarded_objects_on_account_id"
  end

  create_table "sensors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "device_id"
    t.string "name"
    t.integer "status", default: 5, null: false
    t.integer "gpio_listen", default: 0, null: false
    t.integer "gpio_pull", default: 0, null: false
    t.integer "gpio_ok", default: 0, null: false
    t.index ["device_id"], name: "index_sensors_on_device_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "account_id"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_users_on_account_id"
  end

end
