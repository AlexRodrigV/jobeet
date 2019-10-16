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

ActiveRecord::Schema.define(version: 2019_10_16_115825) do

  create_table "applications", force: :cascade do |t|
    t.integer "offer_id"
    t.integer "user_id"
    t.integer "percentage"
    t.string "idchatuser"
    t.string "idchatoffer"
    t.boolean "isAccepted"
  end

  create_table "enterprises", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "user_id"
  end

  create_table "global_data", force: :cascade do |t|
    t.boolean "isConnected"
    t.string "Username"
    t.string "Email"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role"
    t.boolean "reset"
    t.string "image"
    t.boolean "isAdminConnected"
  end

  create_table "offers", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "keywords"
    t.integer "nbModifications", default: 0
    t.integer "recruiter_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "identifier"
  end

  create_table "skill_offers", force: :cascade do |t|
    t.integer "skill_id"
    t.integer "offer_id"
  end

  create_table "skill_users", force: :cascade do |t|
    t.integer "skill_id"
    t.integer "user_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_Skills_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.boolean "isRecruiter"
    t.boolean "isPremium", default: false
    t.integer "situation", default: 2
    t.integer "enterprise_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image"
    t.string "description"
    t.string "hobbies"
    t.string "company"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "resume"
  end

end
