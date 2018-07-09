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

ActiveRecord::Schema.define(version: 2018_07_08_145316) do

  create_table "dishes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "dish_name"
    t.text "description"
    t.text "picture_url"
    t.bigint "hotel_id", null: false
    t.text "dish_type", null: false
    t.integer "price", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_name"], name: "index_dishes_on_dish_name"
    t.index ["hotel_id"], name: "fk_rails_b85da45fcd"
  end

  create_table "hotels", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "avg_price_for_person"
    t.integer "min_order"
    t.string "contact_number"
    t.decimal "latitude", precision: 15, scale: 10
    t.decimal "longitude", precision: 15, scale: 10
    t.integer "from_week_day", limit: 2
    t.integer "to_week_day", limit: 2
    t.time "from_hour_of_day"
    t.time "to_hour_of_day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_hotels_on_name"
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "delivery_address"
    t.bigint "user_id", null: false
    t.bigint "hotel_id", null: false
    t.text "ordered_items", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hotel_id"], name: "fk_rails_984e113617"
    t.index ["user_id"], name: "fk_rails_f868b47f6a"
  end

  create_table "ratings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "stars"
    t.text "review"
    t.integer "up_votes", default: 0
    t.integer "down_votes", default: 0
    t.text "reply_from_hotel"
    t.bigint "hotel_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_ratings_on_created_at"
    t.index ["hotel_id"], name: "fk_rails_526461a96a"
    t.index ["user_id"], name: "fk_rails_a7dfeb9f5f"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "roles", default: 0, null: false
    t.integer "wallet_balance", default: 0
    t.string "address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "dishes", "hotels", on_delete: :cascade
  add_foreign_key "orders", "hotels", on_delete: :cascade
  add_foreign_key "orders", "users", on_delete: :cascade
  add_foreign_key "ratings", "hotels"
  add_foreign_key "ratings", "users"
end
