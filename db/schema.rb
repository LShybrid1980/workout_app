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

ActiveRecord::Schema.define(version: 20170804133150) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abdominals", force: :cascade do |t|
    t.string "status_type"
    t.integer "weight"
    t.integer "set"
    t.integer "rep"
    t.integer "workout_data_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "biceps", force: :cascade do |t|
    t.string "status_type"
    t.integer "weight"
    t.integer "set"
    t.integer "rep"
    t.integer "workout_data_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "calves", force: :cascade do |t|
    t.string "status_type"
    t.integer "weight"
    t.integer "set"
    t.integer "rep"
    t.integer "workout_data_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chests", force: :cascade do |t|
    t.string "status_type"
    t.integer "weight"
    t.integer "set"
    t.integer "rep"
    t.integer "workout_data_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ellipticals", force: :cascade do |t|
    t.string "status_type"
    t.integer "speed"
    t.integer "time"
    t.integer "distance"
    t.integer "incline"
    t.integer "resistance"
    t.integer "workout_data_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "event_type"
    t.json "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "forearms", force: :cascade do |t|
    t.string "status_type"
    t.integer "weight"
    t.integer "set"
    t.integer "rep"
    t.integer "workout_data_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hamstrings", force: :cascade do |t|
    t.string "status_type"
    t.integer "weight"
    t.integer "set"
    t.integer "rep"
    t.integer "workout_data_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lower_backs", force: :cascade do |t|
    t.string "status_type"
    t.integer "weight"
    t.integer "set"
    t.integer "rep"
    t.integer "workout_data_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quads", force: :cascade do |t|
    t.string "status_type"
    t.integer "weight"
    t.integer "set"
    t.integer "rep"
    t.integer "workout_data_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shoulders", force: :cascade do |t|
    t.string "status_type"
    t.integer "weight"
    t.integer "set"
    t.integer "rep"
    t.integer "workout_data_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "treadmills", force: :cascade do |t|
    t.string "status_type"
    t.integer "speed"
    t.integer "time"
    t.integer "incline"
    t.float "distance"
    t.integer "workout_data_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "triceps", force: :cascade do |t|
    t.string "status_type"
    t.integer "weight"
    t.integer "set"
    t.integer "rep"
    t.integer "workout_data_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "upper_backs", force: :cascade do |t|
    t.string "status_type"
    t.integer "weight"
    t.integer "set"
    t.integer "rep"
    t.integer "workout_data_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workout_data", force: :cascade do |t|
    t.date "date"
    t.integer "chest_id"
    t.integer "shoulder_id"
    t.integer "abdominal_id"
    t.integer "bicep_id"
    t.integer "tricep_id"
    t.integer "hamstring_id"
    t.integer "quad_id"
    t.integer "treadmill_id"
    t.integer "elliptical_id"
    t.integer "upper_back_id"
    t.integer "lower_back_id"
    t.integer "forearm_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "events", "users"
end
