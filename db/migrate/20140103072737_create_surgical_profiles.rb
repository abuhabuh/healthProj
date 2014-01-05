class CreateSurgicalProfiles < ActiveRecord::Migration
  def change
    create_table :surgical_profiles do |t|
      t.belongs_to :patient, index: true
      t.belongs_to :user, index: true
      t.integer :patient_status
      t.integer :elective_surgery
      t.string :principal_procedure
      t.string :cpt_code
      t.integer :origin_status
      t.datetime :hospital_admission_date
      t.datetime :operation_date
      t.integer :anesthesia_technique
      t.integer :encounter_number

      t.timestamps
    end

    add_foreign_key(:surgical_profiles, :patients)
    add_foreign_key(:surgical_profiles, :users)
  end
end
