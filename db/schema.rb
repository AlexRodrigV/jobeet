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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2019_09_21_084351) do

  create_table "applications", force: :cascade do |t|
    t.integer "offer_id"
    t.integer "employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "keywords"
  end

  create_table "enterprises", force: :cascade do |t|
    t.string "name"
  end
=======
ActiveRecord::Schema.define(version: 2019_09_21_103227) do
>>>>>>> 5f4ca2148979ce51a227006c1e508728d13a2ddb

  create_table "global_data", force: :cascade do |t|
    t.boolean "isConnected"
    t.string "Username"
    t.string "Email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role"
  end

  create_table "offers", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.string "keywords"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "recruiter_id"
    t.index ["recruiter_id"], name: "index_offers_on_recruiter_id"
  end

  create_table "recruiters", force: :cascade do |t|
    t.string "name"
    t.integer "enterprise_id"
    t.index ["enterprise_id"], name: "index_recruiters_on_enterprise_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
