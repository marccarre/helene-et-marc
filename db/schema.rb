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

ActiveRecord::Schema.define(version: 20131117002437) do

  create_table "bookings", force: true do |t|
    t.string   "email"
    t.string   "phone"
    t.boolean  "coming"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bookings", ["id"], name: "index_bookings_on_id"

  create_table "bookings_events", force: true do |t|
    t.integer "booking_id"
    t.integer "event_id"
  end

  add_index "bookings_events", ["booking_id"], name: "index_bookings_events_on_booking_id"
  add_index "bookings_events", ["event_id"], name: "index_bookings_events_on_event_id"

  create_table "cars", force: true do |t|
    t.string   "from"
    t.string   "to"
    t.datetime "departure_time"
    t.datetime "arrival_time"
    t.integer  "available_seats"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cars", ["id"], name: "index_cars_on_id"

  create_table "events", force: true do |t|
    t.string   "locale_entry"
    t.datetime "beginning"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "events", ["id"], name: "index_events_on_id"

  create_table "guests", force: true do |t|
    t.integer  "booking_id"
    t.string   "first_name"
    t.string   "family_name"
    t.integer  "category"
    t.integer  "menu"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "guests", ["booking_id"], name: "index_guests_on_booking_id"
  add_index "guests", ["id"], name: "index_guests_on_id"

  create_table "parameters", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "passengers", force: true do |t|
    t.integer  "car_id"
    t.string   "first_name"
    t.string   "family_name"
    t.string   "email"
    t.string   "phone"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "passengers", ["car_id"], name: "index_passengers_on_car_id"
  add_index "passengers", ["id"], name: "index_passengers_on_id"

end
