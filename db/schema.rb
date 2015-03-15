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

ActiveRecord::Schema.define(version: 20150313194928) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bracket_games", force: true do |t|
    t.string  "team_one"
    t.string  "team_two"
    t.integer "team_one_id"
    t.integer "team_two_id"
    t.integer "game_id"
    t.string  "advance"
  end

  create_table "brackets", force: true do |t|
    t.integer  "bracket_game_id"
    t.integer  "team_id"
    t.string   "location"
    t.string   "advance"
    t.string   "opponent"
    t.boolean  "win"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.integer  "espn_id"
    t.string   "status"
    t.integer  "home_team"
    t.integer  "away_team"
    t.integer  "home_score"
    t.integer  "away_score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "name"
    t.string   "gp"
    t.string   "min"
    t.string   "ppg"
    t.string   "rpg"
    t.string   "apg"
    t.string   "spg"
    t.string   "bpg"
    t.string   "tpg"
    t.string   "fg"
    t.string   "ft"
    t.string   "threep"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: true do |t|
    t.integer  "first"
    t.integer  "second"
    t.integer  "ot"
    t.integer  "game_id"
    t.boolean  "win"
    t.string   "team"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "img_url"
    t.string   "o_ppg"
    t.string   "o_rpg"
    t.string   "o_apg"
    t.string   "o_fg"
    t.string   "d_ppg"
    t.string   "d_rpg"
    t.string   "d_bpg"
    t.string   "d_spg"
    t.string   "o_ppg_rank"
    t.string   "o_rpg_rank"
    t.string   "o_apg_rank"
    t.string   "o_fg_rank"
    t.string   "d_ppg_rank"
    t.string   "d_rpg_rank"
    t.string   "d_bpg_rank"
    t.string   "d_spg_rank"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "rank"
    t.integer  "espn_id"
    t.string   "mmid"
    t.integer  "mmrank"
  end

  create_table "user_brackets", force: true do |t|
    t.integer  "points"
    t.json     "bracket"
    t.string   "name"
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
