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

ActiveRecord::Schema.define(version: 2022_04_27_093159) do

  create_table "buildings", force: :cascade do |t|
    t.string "reference"
    t.string "address"
    t.string "zip_code"
    t.string "city"
    t.string "country"
    t.string "manager_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "histories", force: :cascade do |t|
    t.string "column"
    t.string "value"
    t.string "memorable_type"
    t.integer "memorable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["memorable_type", "memorable_id"], name: "index_histories_on_memorable"
    t.index ["memorable_type", "memorable_id"], name: "index_histories_on_memorable_type_and_memorable_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "reference"
    t.string "email"
    t.string "home_phone_number"
    t.string "mobile_phone_number"
    t.string "firstname"
    t.string "lastname"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
