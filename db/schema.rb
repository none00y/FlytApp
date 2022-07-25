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

ActiveRecord::Schema.define(version: 2022_07_25_133739) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "airfields", force: :cascade do |t|
    t.string "name"
    t.float "latitude"
    t.float "longitude"
    t.integer "airfield_plane_capacity"
  end

  create_table "airplanes", force: :cascade do |t|
    t.string "identifier"
    t.integer "state"
    t.float "flight_speed"
    t.integer "departure_day"
    t.time "departure_time"
    t.float "percentage_of_distance_travelled"
    t.integer "passenger_capacity"
    t.bigint "connection_id"
    t.boolean "direction"
    t.index ["connection_id"], name: "index_airplanes_on_connection_id"
  end

  create_table "connections", force: :cascade do |t|
    t.float "distance"
    t.bigint "airfield_a_id"
    t.bigint "airfield_b_id"
    t.index ["airfield_a_id"], name: "index_connections_on_airfield_a_id"
    t.index ["airfield_b_id"], name: "index_connections_on_airfield_b_id"
  end

  create_table "passengers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "state"
    t.bigint "airplane_id"
    t.index ["airplane_id"], name: "index_passengers_on_airplane_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "connections", "airfields", column: "airfield_a_id"
  add_foreign_key "connections", "airfields", column: "airfield_b_id"
end
