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

ActiveRecord::Schema.define(version: 2018_07_04_060311) do

  create_table "dish_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_dish_types_on_name"
  end

  create_table "dishes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "picture_url"
    t.bigint "hotel_id", null: false
    t.bigint "dish_type_id", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_type_id"], name: "fk_rails_51aec8c948"
    t.index ["hotel_id"], name: "fk_rails_b85da45fcd"
    t.index ["name"], name: "index_dishes_on_name"
  end

  create_table "hotels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "avg_price_for_person"
    t.integer "min_order"
    t.boolean "is_closed_for_now"
    t.string "contact_number"
    t.boolean "is_verified"
    t.decimal "latitude", precision: 15, scale: 10
    t.decimal "longitude", precision: 15, scale: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["is_closed_for_now"], name: "index_hotels_on_is_closed_for_now"
    t.index ["is_verified"], name: "index_hotels_on_is_verified"
    t.index ["name"], name: "index_hotels_on_name"
  end

  create_table "open_hours", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "from_week_day", limit: 2
    t.integer "to_week_day", limit: 2
    t.time "from_hour_of_day"
    t.time "to_hour_of_day"
    t.bigint "hotel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "fk_rails_4ac3edee5a"
  end

  create_table "order_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "delivery_address"
    t.bigint "user_id", null: false
    t.bigint "hotel_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "fk_rails_8d58df4c45"
    t.index ["user_id"], name: "fk_rails_67f58df321"
  end

  create_table "ordered_items", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "dish_id", null: false
    t.bigint "order_detail_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "fk_rails_ee74720cbf"
    t.index ["order_detail_id"], name: "fk_rails_3b55c4b4f3"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "contact_number", null: false
    t.integer "wallet_balance", default: 0
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["name"], name: "index_users_on_name"
  end

  add_foreign_key "dishes", "dish_types"
  add_foreign_key "dishes", "hotels", on_delete: :cascade
  add_foreign_key "open_hours", "hotels", on_delete: :cascade
  add_foreign_key "order_details", "hotels", on_delete: :cascade
  add_foreign_key "order_details", "users", on_delete: :cascade
  add_foreign_key "ordered_items", "dishes", on_delete: :cascade
  add_foreign_key "ordered_items", "order_details", on_delete: :cascade
end
