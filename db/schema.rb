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

ActiveRecord::Schema.define(version: 2018_08_28_234907) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_favorites_on_spot_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating"
    t.text "content"
    t.bigint "user_id"
    t.bigint "spot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_reviews_on_spot_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "spots", force: :cascade do |t|
    t.bigint "city_id"
    t.bigint "user_id"
    t.string "address"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.boolean "active", default: true, null: false
    t.string "country"
    t.index ["city_id"], name: "index_spots_on_city_id"
    t.index ["user_id"], name: "index_spots_on_user_id"
  end

  create_table "spots_categories", force: :cascade do |t|
    t.bigint "spot_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_spots_categories_on_category_id"
    t.index ["spot_id"], name: "index_spots_categories_on_spot_id"
  end

  create_table "spots_photos", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "spot_id"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spot_id"], name: "index_spots_photos_on_spot_id"
    t.index ["user_id"], name: "index_spots_photos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "city_id"
    t.string "avatar"
    t.string "username"
    t.string "name"
    t.text "description"
    t.index ["city_id"], name: "index_users_on_city_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "favorites", "spots"
  add_foreign_key "favorites", "users"
  add_foreign_key "reviews", "spots"
  add_foreign_key "reviews", "users"
  add_foreign_key "spots", "cities"
  add_foreign_key "spots", "users"
  add_foreign_key "spots_categories", "categories"
  add_foreign_key "spots_categories", "spots"
  add_foreign_key "spots_photos", "spots"
  add_foreign_key "spots_photos", "users"
  add_foreign_key "users", "cities"
end
