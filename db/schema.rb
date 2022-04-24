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

ActiveRecord::Schema.define(version: 2022_04_19_043811) do

  create_table "events", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "topic_id"
    t.string "name"
    t.text "description"
    t.datetime "happen_at"
    t.string "location"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["topic_id"], name: "index_events_on_topic_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "tasks", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "topic_id"
    t.bigint "parent_id"
    t.string "name"
    t.text "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.decimal "estimated_costs", precision: 10, default: "0"
    t.decimal "actual_costs", precision: 10, default: "0"
    t.float "progress", default: 0.0
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "images"
    t.index ["event_id"], name: "index_tasks_on_event_id"
    t.index ["parent_id"], name: "index_tasks_on_parent_id"
    t.index ["topic_id"], name: "index_tasks_on_topic_id"
  end

  create_table "topics", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.date "date_of_birth"
    t.string "address"
    t.integer "gender", default: 0
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "events", "topics"
  add_foreign_key "events", "users"
  add_foreign_key "tasks", "events"
  add_foreign_key "tasks", "tasks", column: "parent_id"
  add_foreign_key "tasks", "topics"
end
