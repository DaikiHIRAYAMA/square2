# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_15_090216) do

  create_table "records", force: :cascade do |t|
    t.integer "transaction_id", null: false
    t.integer "user_id", null: false
    t.boolean "read", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "item_name"
    t.datetime "time_limit"
    t.datetime "start_time"
    t.string "description"
    t.integer "current_situation"
    t.index ["transaction_id"], name: "index_records_on_transaction_id"
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "rends", force: :cascade do |t|
    t.string "item_name"
    t.datetime "time_limit"
    t.datetime "start_time"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "render_id"
    t.integer "borrower_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["borrower_id"], name: "index_transactions_on_borrower_id"
    t.index ["render_id", "borrower_id"], name: "index_transactions_on_render_id_and_borrower_id", unique: true
    t.index ["render_id"], name: "index_transactions_on_render_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "records", "transactions"
  add_foreign_key "records", "users"
end
