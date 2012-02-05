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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120205150214) do

  create_table "weather_conditions", :force => true do |t|
    t.string   "condition"
    t.integer  "temperature"
    t.integer  "wind_speed"
    t.integer  "zipcode_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "weather_conditions", ["zipcode_id"], :name => "index_weather_conditions_on_zipcode_id"

  create_table "zipcodes", :force => true do |t|
    t.string   "zipcode"
    t.float    "lat"
    t.float    "lng"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "population"
    t.string   "weather_station"
  end

end
