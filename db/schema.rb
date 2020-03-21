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

ActiveRecord::Schema.define(version: 2020_03_21_185205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "heatmap_values", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "heatmap_id", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.float "percentage_sick", null: false
    t.index ["heatmap_id"], name: "index_heatmap_values_on_heatmap_id"
    t.index ["latitude", "longitude"], name: "index_heatmap_values_on_latitude_and_longitude"
  end

  create_table "heatmaps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.float "radius_km", null: false
    t.datetime "data_starts_at", null: false
    t.datetime "data_ends_at", null: false
    t.boolean "simulated", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "questionnaires", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "client_uuid", null: false
    t.boolean "healthy", null: false
    t.boolean "tested", null: false
    t.boolean "fever", null: false
    t.boolean "cough", null: false
    t.string "other_symptoms", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.text "address"
    t.float "accuracy", null: false
    t.boolean "simulated", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["latitude", "longitude"], name: "index_questionnaires_on_latitude_and_longitude"
  end

  add_foreign_key "heatmap_values", "heatmaps"
end
