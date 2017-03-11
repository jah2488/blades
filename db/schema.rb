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

ActiveRecord::Schema.define(version: 20170311135016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "game_id"
  end

  create_table "characters", id: :serial, force: :cascade do |t|
    t.integer "game_id"
    t.string "name"
    t.text "description"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_characters_on_game_id"
  end

  create_table "district_characters", id: :serial, force: :cascade do |t|
    t.integer "district_id"
    t.integer "character_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_district_characters_on_character_id"
    t.index ["district_id"], name: "index_district_characters_on_district_id"
  end

  create_table "district_factions", id: :serial, force: :cascade do |t|
    t.integer "district_id"
    t.integer "faction_id"
    t.boolean "in_control"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_district_factions_on_district_id"
    t.index ["faction_id"], name: "index_district_factions_on_faction_id"
  end

  create_table "districts", id: :serial, force: :cascade do |t|
    t.integer "game_id"
    t.string "name", null: false
    t.text "description"
    t.integer "wealth", default: 0
    t.integer "security_and_safety", default: 0
    t.integer "criminal_influence", default: 0
    t.integer "occult_influence", default: 0
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_districts_on_game_id"
  end

  create_table "faction_characters", id: :serial, force: :cascade do |t|
    t.integer "faction_id"
    t.integer "character_id"
    t.boolean "leader"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_faction_characters_on_character_id"
    t.index ["faction_id"], name: "index_faction_characters_on_faction_id"
  end

  create_table "factions", id: :serial, force: :cascade do |t|
    t.integer "game_id"
    t.integer "category_id"
    t.string "name", null: false
    t.text "description"
    t.integer "reputation", default: 0
    t.integer "hold", default: 0
    t.integer "turf", default: 0
    t.integer "faction_status", default: 0
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_factions_on_category_id"
    t.index ["game_id"], name: "index_factions_on_game_id"
  end

  create_table "games", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name", null: false
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.boolean "active", default: false
    t.string "join_token"
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "player_traumas", id: :serial, force: :cascade do |t|
    t.integer "player_id"
    t.integer "trauma_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_player_traumas_on_player_id"
    t.index ["trauma_id"], name: "index_player_traumas_on_trauma_id"
  end

  create_table "players", id: :serial, force: :cascade do |t|
    t.integer "game_id"
    t.string "name"
    t.text "description"
    t.string "playbook"
    t.integer "stress"
    t.integer "coin"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
  end

  create_table "traumas", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_players", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_user_players_on_player_id"
    t.index ["user_id"], name: "index_user_players_on_user_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.integer "current_game_id"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  add_foreign_key "characters", "games"
  add_foreign_key "district_characters", "characters"
  add_foreign_key "district_characters", "districts"
  add_foreign_key "district_factions", "districts"
  add_foreign_key "district_factions", "factions"
  add_foreign_key "districts", "games"
  add_foreign_key "faction_characters", "characters"
  add_foreign_key "faction_characters", "factions"
  add_foreign_key "factions", "categories"
  add_foreign_key "factions", "games"
  add_foreign_key "games", "users"
  add_foreign_key "player_traumas", "players"
  add_foreign_key "player_traumas", "traumas"
  add_foreign_key "players", "games"
  add_foreign_key "user_players", "players"
  add_foreign_key "user_players", "users"
end
