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

ActiveRecord::Schema.define(version: 20170202081556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_pages", force: :cascade do |t|
    t.integer  "number"
    t.text     "content"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_pages_on_book_id", using: :btree
  end

  create_table "books", force: :cascade do |t|
    t.string   "name",       limit: 50
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "languages", force: :cascade do |t|
    t.integer  "order"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "os_pages", force: :cascade do |t|
    t.integer  "number"
    t.text     "content"
    t.integer  "os_project_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["os_project_id"], name: "index_os_pages_on_os_project_id", using: :btree
  end

  create_table "os_projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "language_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "order"
    t.index ["language_id"], name: "index_os_projects_on_language_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_hash"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_foreign_key "book_pages", "books"
  add_foreign_key "os_pages", "os_projects"
  add_foreign_key "os_projects", "languages"
end
