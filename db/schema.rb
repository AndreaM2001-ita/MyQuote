# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_08_22_084701) do
  create_table "categories", force: :cascade do |t|
    t.string "catName", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["catName"], name: "index_categories_on_catName", unique: true
  end

  create_table "category_quotes", force: :cascade do |t|
    t.integer "quote_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_quotes_on_category_id"
    t.index ["quote_id"], name: "index_category_quotes_on_quote_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "comment", null: false
    t.date "datePosted", null: false
    t.integer "User_id", null: false
    t.integer "Quote_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["Quote_id"], name: "index_comments_on_Quote_id"
    t.index ["User_id"], name: "index_comments_on_User_id"
  end

  create_table "philosophers", force: :cascade do |t|
    t.string "firstName", null: false
    t.string "lastName", null: false
    t.integer "birthYear", null: false
    t.integer "deathYear"
    t.text "biography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", force: :cascade do |t|
    t.string "quoteText", null: false
    t.boolean "isPublic", null: false
    t.date "datePosted", null: false
    t.integer "User_id", null: false
    t.integer "Philosopher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["Philosopher_id"], name: "index_quotes_on_Philosopher_id"
    t.index ["User_id"], name: "index_quotes_on_User_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstName", null: false
    t.string "lastName", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "status", null: false
    t.boolean "is_admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "category_quotes", "categories"
  add_foreign_key "category_quotes", "quotes"
  add_foreign_key "comments", "Quotes"
  add_foreign_key "comments", "Users"
  add_foreign_key "quotes", "Philosophers"
  add_foreign_key "quotes", "Users"
end

# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_08_22_084701) do
  create_table "categories", force: :cascade do |t|
    t.string "catName", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["catName"], name: "index_categories_on_catName", unique: true
  end

  create_table "category_quotes", force: :cascade do |t|
    t.integer "quote_id", null: false
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_category_quotes_on_category_id"
    t.index ["quote_id"], name: "index_category_quotes_on_quote_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "comment", null: false
    t.date "datePosted", null: false
    t.integer "User_id", null: false
    t.integer "Quote_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["Quote_id"], name: "index_comments_on_Quote_id"
    t.index ["User_id"], name: "index_comments_on_User_id"
  end

  create_table "philosophers", force: :cascade do |t|
    t.string "firstName", null: false
    t.string "lastName", null: false
    t.integer "birthYear", null: false
    t.integer "deathYear"
    t.text "biography"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", force: :cascade do |t|
    t.string "quoteText", null: false
    t.boolean "isPublic", null: false
    t.date "datePosted", null: false
    t.integer "User_id", null: false
    t.integer "Philosopher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["Philosopher_id"], name: "index_quotes_on_Philosopher_id"
    t.index ["User_id"], name: "index_quotes_on_User_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "firstName", null: false
    t.string "lastName", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "status", null: false
    t.boolean "is_admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "category_quotes", "categories"
  add_foreign_key "category_quotes", "quotes"
  add_foreign_key "comments", "Quotes"
  add_foreign_key "comments", "Users"
  add_foreign_key "quotes", "Philosophers"
  add_foreign_key "quotes", "Users"
end
