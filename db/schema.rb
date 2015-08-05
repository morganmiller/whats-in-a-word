ActiveRecord::Schema.define(version: 20150804204456) do

  enable_extension "plpgsql"

  create_table "quotes", force: :cascade do |t|
    t.text     "body"
    t.string   "speaker"
    t.integer  "word_id"
    t.integer  "sentiment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "quotes", ["word_id"], name: "index_quotes_on_word_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "words", force: :cascade do |t|
    t.string   "word"
    t.integer  "mentions"
    t.integer  "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "words", ["state_id"], name: "index_words_on_state_id", using: :btree

  add_foreign_key "quotes", "words"
  add_foreign_key "words", "states"
end
