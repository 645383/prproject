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

ActiveRecord::Schema.define(version: 20141003092256) do

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.integer  "height"
    t.string   "hair_color"
    t.integer  "weight"
    t.integer  "country_id"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "body_type"
    t.integer  "foot_size"
  end

  create_table "world_boundaries", force: true do |t|
    t.text    "fips"
    t.text    "iso2"
    t.text    "iso3"
    t.integer "un"
    t.text    "name"
    t.integer "area"
    t.integer "pop2005"
    t.integer "region"
    t.integer "subregion"
    t.float   "lon"
    t.float   "lat"
    t.text    "ogc_geom"
  end

end
