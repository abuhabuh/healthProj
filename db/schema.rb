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

ActiveRecord::Schema.define(version: 20140223080716) do

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
    t.string   "encrypted_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_name_salt"
    t.string   "encrypted_name_iv"
  end

  add_index "ethnicities", ["encrypted_name"], name: "index_ethnicities_on_encrypted_name", unique: true, using: :btree

  create_table "healthcare_providers", force: true do |t|
    t.string   "name"
    t.integer  "provider_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "languages", force: true do |t|
    t.string   "encrypted_name"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_name_salt"
    t.string   "encrypted_name_iv"
  end

  add_index "languages", ["country_id"], name: "languages_country_id_fk", using: :btree
  add_index "languages", ["encrypted_name"], name: "index_languages_on_encrypted_name", unique: true, using: :btree

  create_table "patients", force: true do |t|
    t.string   "encrypted_last_name"
    t.string   "encrypted_first_name"
    t.string   "encrypted_middle_initial"
    t.string   "encrypted_address1"
    t.string   "encrypted_address2"
    t.string   "encrypted_city"
    t.string   "encrypted_state"
    t.string   "encrypted_home_phone"
    t.string   "encrypted_work_phone"
    t.string   "encrypted_cell_phone"
    t.string   "encrypted_gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "race_id"
    t.integer  "ethnicity_id"
    t.integer  "language_id"
    t.string   "encrypted_medical_record_id"
    t.string   "encrypted_date_of_birth"
    t.string   "encrypted_medical_record_id_salt"
    t.string   "encrypted_medical_record_id_iv"
    t.string   "encrypted_date_of_birth_salt"
    t.string   "encrypted_date_of_birth_iv"
    t.string   "encrypted_last_name_salt"
    t.string   "encrypted_last_name_iv"
    t.string   "encrypted_first_name_salt"
    t.string   "encrypted_first_name_iv"
    t.string   "encrypted_middle_initial_salt"
    t.string   "encrypted_middle_initial_iv"
    t.string   "encrypted_address1_salt"
    t.string   "encrypted_address1_iv"
    t.string   "encrypted_address2_salt"
    t.string   "encrypted_address2_iv"
    t.string   "encrypted_city_salt"
    t.string   "encrypted_city_iv"
    t.string   "encrypted_state_salt"
    t.string   "encrypted_state_iv"
    t.string   "encrypted_home_phone_salt"
    t.string   "encrypted_home_phone_iv"
    t.string   "encrypted_work_phone_salt"
    t.string   "encrypted_work_phone_iv"
    t.string   "encrypted_cell_phone_salt"
    t.string   "encrypted_cell_phone_iv"
    t.string   "encrypted_gender_salt"
    t.string   "encrypted_gender_iv"
  end

  add_index "patients", ["ethnicity_id"], name: "patients_ethnicity_id_fk", using: :btree
  add_index "patients", ["language_id"], name: "patients_language_id_fk", using: :btree
  add_index "patients", ["race_id"], name: "patients_race_id_fk", using: :btree

  create_table "preop_risk_assessments", force: true do |t|
    t.integer  "surgical_profile_id"
    t.integer  "bit_field"
    t.decimal  "height",                   precision: 7, scale: 4
    t.decimal  "weight",                   precision: 7, scale: 4
    t.integer  "diabetes_mellitus"
    t.integer  "functional_health_status"
    t.integer  "sepsis_within_48hrs"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "preop_risk_assessments", ["surgical_profile_id"], name: "index_preop_risk_assessments_on_surgical_profile_id", using: :btree

  create_table "races", force: true do |t|
    t.string   "encrypted_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_name_salt"
    t.string   "encrypted_name_iv"
  end

  add_index "races", ["encrypted_name"], name: "index_races_on_encrypted_name", unique: true, using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surgeon_specialties", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surgical_profiles", force: true do |t|
    t.integer  "patient_id"
    t.integer  "user_id"
    t.integer  "patient_status"
    t.integer  "elective_surgery"
    t.string   "principal_procedure"
    t.string   "cpt_code"
    t.integer  "origin_status"
    t.integer  "anesthesia_technique"
    t.integer  "encounter_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_hospital_admission_date"
    t.string   "encrypted_operation_date"
    t.string   "encrypted_hospital_admission_date_salt"
    t.string   "encrypted_hospital_admission_date_iv"
    t.string   "encrypted_operation_date_salt"
    t.string   "encrypted_operation_date_iv"
  end

  add_index "surgical_profiles", ["patient_id"], name: "index_surgical_profiles_on_patient_id", using: :btree
  add_index "surgical_profiles", ["user_id"], name: "index_surgical_profiles_on_user_id", using: :btree

  create_table "survey_answers", force: true do |t|
    t.string   "answer_text"
    t.integer  "answer_value"
    t.integer  "survey_question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "survey_answers", ["survey_question_id"], name: "index_survey_answers_on_survey_question_id", using: :btree

  create_table "survey_questions", force: true do |t|
    t.string   "question_text"
    t.integer  "is_active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "user_surgeon_profiles", force: true do |t|
    t.integer  "user_id"
    t.integer  "surgeon_specialty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_surgeon_profiles", ["surgeon_specialty_id"], name: "user_surgeon_profiles_surgeon_specialty_id_fk", using: :btree
  add_index "user_surgeon_profiles", ["user_id"], name: "user_surgeon_profiles_user_id_fk", using: :btree

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
    t.string   "first_name"
    t.string   "last_name"
    t.string   "middle_initial"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "departments", "healthcare_providers", name: "departments_healthcare_provider_id_fk"

  add_foreign_key "languages", "countries", name: "languages_country_id_fk"

  add_foreign_key "patients", "ethnicities", name: "patients_ethnicity_id_fk"
  add_foreign_key "patients", "languages", name: "patients_language_id_fk"
  add_foreign_key "patients", "races", name: "patients_race_id_fk"

  add_foreign_key "preop_risk_assessments", "surgical_profiles", name: "preop_risk_assessments_surgical_profile_id_fk"

  add_foreign_key "surgical_profiles", "patients", name: "surgical_profiles_patient_id_fk"
  add_foreign_key "surgical_profiles", "users", name: "surgical_profiles_user_id_fk"

  add_foreign_key "survey_answers", "survey_questions", name: "survey_answers_survey_question_id_fk"

  add_foreign_key "user_roles", "roles", name: "user_roles_role_id_fk"
  add_foreign_key "user_roles", "users", name: "user_roles_user_id_fk"

  add_foreign_key "user_surgeon_profiles", "surgeon_specialties", name: "user_surgeon_profiles_surgeon_specialty_id_fk"
  add_foreign_key "user_surgeon_profiles", "users", name: "user_surgeon_profiles_user_id_fk"

end
