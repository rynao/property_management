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

ActiveRecord::Schema.define(version: 2022_02_01_000459) do

  create_table "contracts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "rent", null: false
    t.bigint "property_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["property_id"], name: "index_contracts_on_property_id"
    t.index ["room_id"], name: "index_contracts_on_room_id"
    t.index ["user_id"], name: "index_contracts_on_user_id"
  end

  create_table "payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "paid_date", null: false
    t.boolean "paid", default: false, null: false
    t.bigint "property_id", null: false
    t.bigint "room_id", null: false
    t.bigint "contract_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["contract_id"], name: "index_payments_on_contract_id"
    t.index ["property_id"], name: "index_payments_on_property_id"
    t.index ["room_id"], name: "index_payments_on_room_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "properties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "postal_code"
    t.string "prefecture", null: false
    t.string "city", null: false
    t.string "address_line"
    t.string "building", null: false
    t.integer "total_units"
    t.date "building_year"
    t.string "property_type"
    t.string "business_entity", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "room_name"
    t.bigint "property_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["property_id"], name: "index_rooms_on_property_id"
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contracts", "properties"
  add_foreign_key "contracts", "rooms"
  add_foreign_key "contracts", "users"
  add_foreign_key "payments", "contracts"
  add_foreign_key "payments", "properties"
  add_foreign_key "payments", "rooms"
  add_foreign_key "payments", "users"
  add_foreign_key "properties", "users"
  add_foreign_key "rooms", "properties"
  add_foreign_key "rooms", "users"
end
