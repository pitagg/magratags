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

ActiveRecord::Schema.define(version: 20190314131912) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "credentials", force: :cascade do |t|
    t.string   "provider"
    t.string   "name"
    t.string   "consumer_key"
    t.string   "consumer_secret"
    t.string   "access_token"
    t.string   "access_token_secret"
    t.integer  "user_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.index ["user_id"], name: "index_credentials_on_user_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.string   "provider"
    t.string   "provider_user_id"
    t.string   "provider_user_name"
    t.string   "provider_user_image"
    t.string   "provider_user_screen_name"
    t.text     "provider_user_description"
    t.text     "message"
    t.string   "uri"
    t.datetime "published_at"
    t.boolean  "retweeted"
    t.string   "lang"
    t.json     "complete_data"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "tweet_id"
  end

  create_table "posts_searches", id: false, force: :cascade do |t|
    t.integer "post_id"
    t.integer "search_id"
    t.index ["post_id"], name: "index_posts_searches_on_post_id", using: :btree
    t.index ["search_id", "post_id"], name: "index_posts_searches_on_search_id_and_post_id", using: :btree
    t.index ["search_id"], name: "index_posts_searches_on_search_id", using: :btree
  end

  create_table "searches", force: :cascade do |t|
    t.string   "name"
    t.string   "expression"
    t.boolean  "ignore_rt",     default: false
    t.string   "last_tweet_id"
    t.datetime "synced_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "credentials", "users"
end
