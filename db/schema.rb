# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131230063029) do

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  add_index "countries", ["name"], name: "index_countries_on_name", unique: true, using: :btree

  create_table "departments", force: true do |t|
    t.string   "name"
    t.integer  "healthcare_provider_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "departments", ["healthcare_provider_id"], name: "index_departments_on_health_care_provider_id", using: :btree
  add_index "departments", ["name", "healthcare_provider_id"], name: "index_departments_on_name_and_health_care_provider_id", unique: true, using: :btree

  create_table "ethnicities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ethnicities", ["name"], name: "index_ethnicities_on_name", unique: true, using: :btree

  create_table "healthcare_providers", force: true do |t|
    t.string   "name"
    t.integer  "provider_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", force: true do |t|
    t.string   "name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "languages", ["country_id"], name: "languages_country_id_fk", using: :btree
  add_index "languages", ["name"], name: "index_languages_on_name", unique: true, using: :btree

  create_table "patients", force: true do |t|
    t.integer  "medical_record_id"
    t.string   "last_name"
    t.string   "first_name"
    t.string   "middle_initial"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "home_phone"
    t.string   "work_phone"
    t.string   "cell_phone"
    t.date     "date_of_birth"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "race_id"
    t.integer  "ethnicity_id"
    t.integer  "language_id"
  end

  add_index "patients", ["ethnicity_id"], name: "patients_ethnicity_id_fk", using: :btree
  add_index "patients", ["language_id"], name: "patients_language_id_fk", using: :btree
  add_index "patients", ["medical_record_id"], name: "index_patients_on_medical_record_id", unique: true, using: :btree
  add_index "patients", ["race_id"], name: "patients_race_id_fk", using: :btree

  create_table "races", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "races", ["name"], name: "index_races_on_name", unique: true, using: :btree

  create_table "surgeon_specialties", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "languages", "countries", name: "languages_country_id_fk"

  add_foreign_key "patients", "ethnicities", name: "patients_ethnicity_id_fk"
  add_foreign_key "patients", "languages", name: "patients_language_id_fk"
  add_foreign_key "patients", "races", name: "patients_race_id_fk"

end
