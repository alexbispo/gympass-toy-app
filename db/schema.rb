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

ActiveRecord::Schema.define(version: 20161012211643) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gym_users", force: :cascade do |t|
    t.integer  "gym_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gym_id"], name: "index_gym_users_on_gym_id", using: :btree
    t.index ["user_id"], name: "index_gym_users_on_user_id", using: :btree
  end

  create_table "gyms", force: :cascade do |t|
    t.string   "name",                limit: 100,             null: false
    t.string   "cnpj",                limit: 14,              null: false
    t.string   "opening_time_in_sec",                         null: false
    t.string   "closing_time_in_sec",                         null: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "status",                          default: 0
    t.index ["cnpj"], name: "index_gyms_on_cnpj", unique: true, using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "latitude",         null: false
    t.string   "longitude",        null: false
    t.integer  "type_of_location", null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "localizable_id"
    t.string   "localizable_type"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",               limit: 100, null: false
    t.string   "email",              limit: 100, null: false
    t.string   "cpf",                limit: 11,  null: false
    t.string   "password_digest",                null: false
    t.integer  "role",                           null: false
    t.datetime "confirmed_at"
    t.string   "confirmation_token"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["cpf"], name: "index_users_on_cpf", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "gym_users", "gyms"
  add_foreign_key "gym_users", "users"
end
