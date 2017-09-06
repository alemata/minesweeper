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

ActiveRecord::Schema.define(version: 20170906135557) do

  create_table "games", force: :cascade do |t|
    t.string   "status"
    t.integer  "rows"
    t.integer  "columns"
    t.integer  "mines_count"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "tiles", force: :cascade do |t|
    t.integer  "row"
    t.integer  "column"
    t.boolean  "mine",                 default: false
    t.boolean  "revealed",             default: false
    t.integer  "game_id"
    t.integer  "neighbor_mines_count", default: 0
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.index ["game_id"], name: "index_tiles_on_game_id"
  end

end
