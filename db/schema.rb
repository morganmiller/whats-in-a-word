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

ActiveRecord::Schema.define(version: 20150811170923) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "legislators", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "party"
    t.string   "phone"
    t.integer  "state_id"
    t.string   "term_start"
    t.string   "term_end"
    t.string   "twitter_handle"
    t.string   "title"
    t.string   "website"
    t.string   "bio_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "legislators", ["state_id"], name: "index_legislators_on_state_id", using: :btree

  create_table "quotes", force: :cascade do |t|
    t.text     "body"
    t.string   "speaker"
    t.integer  "word_id"
    t.float    "sentiment"
    t.string   "bio_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "legislator_id"
  end

  add_index "quotes", ["legislator_id"], name: "index_quotes_on_legislator_id", using: :btree
  add_index "quotes", ["word_id"], name: "index_quotes_on_word_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.string   "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "screen_name"
    t.string   "uid"
    t.string   "oauth_token"
    t.string   "oauth_token_secret"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "words", force: :cascade do |t|
    t.string   "word"
    t.integer  "mentions"
    t.integer  "state_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "legislator_id"
  end

  add_index "words", ["legislator_id"], name: "index_words_on_legislator_id", using: :btree
  add_index "words", ["state_id"], name: "index_words_on_state_id", using: :btree

  add_foreign_key "legislators", "states"
  add_foreign_key "quotes", "legislators"
  add_foreign_key "quotes", "words"
  add_foreign_key "words", "legislators"
  add_foreign_key "words", "states"
end
