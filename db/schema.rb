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

ActiveRecord::Schema.define(version: 2020_03_06_140432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "browser_locations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.text "address"
    t.float "accuracy", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questionnaires", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "client_uuid", null: false
    t.boolean "healthy", null: false
    t.boolean "tested", null: false
    t.boolean "fever", null: false
    t.boolean "cough", null: false
    t.text "other_symptoms"
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.text "address"
    t.float "accuracy", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
