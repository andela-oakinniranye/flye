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

ActiveRecord::Schema.define(version: 20150910144001) do

  create_table "airports", force: :cascade do |t|
    t.string   "name"
    t.string   "location"
    t.string   "symbol"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "flight_id"
    t.integer  "user_id"
    t.integer  "status",     default: 0, null: false
    t.integer  "amount"
    t.string   "txn_id"
    t.string   "uniq_id"
  end

  create_table "flights", force: :cascade do |t|
    t.integer  "origin_id"
    t.integer  "destination_id"
    t.datetime "departure_date"
    t.datetime "arrival_date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name"
    t.integer  "passenger_count", default: 0, null: false
    t.integer  "price",           default: 0, null: false
  end

  add_index "flights", ["destination_id"], name: "index_flights_on_destination_id"
  add_index "flights", ["origin_id"], name: "index_flights_on_origin_id"

  create_table "passengers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.string   "last_name"
  end

  add_index "passengers", ["user_id"], name: "index_passengers_on_user_id"

  create_table "reservations", force: :cascade do |t|
    t.integer  "booking_id"
    t.integer  "passenger_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "reservations", ["booking_id"], name: "index_reservations_on_booking_id"
  add_index "reservations", ["passenger_id"], name: "index_reservations_on_passenger_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "provider"
    t.string   "uuid"
    t.string   "profile_url"
    t.string   "auth_token"
    t.datetime "oauth_token_expires_at"
  end

end
