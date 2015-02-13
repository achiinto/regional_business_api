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

ActiveRecord::Schema.define(version: 20150213015404) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_clients", force: :cascade do |t|
    t.integer  "daily_api_count"
    t.string   "consumer_key"
    t.string   "consumer_secret"
    t.string   "api_token"
    t.string   "api_token_secret"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "businesses", force: :cascade do |t|
    t.string   "resource_id"
    t.string   "name"
    t.string   "image_url"
    t.string   "url"
    t.string   "phone"
    t.integer  "review_count"
    t.text     "categories",      default: [],              array: true
    t.string   "display_address"
    t.boolean  "is_closed"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string   "name"
    t.float    "sw_latitude"
    t.float    "sw_longitude"
    t.float    "ne_latitude"
    t.float    "ne_longitude"
    t.integer  "current_index", default: 0
    t.string   "source_type",   default: "yelp"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

end
