# Encrypt date columns as per PHI regulations

class EncryptSurgicalProfiles < ActiveRecord::Migration
  def change
    # Delete date type columns and change to string columns
    remove_column :surgical_profiles, :hospital_admission_date
    add_column :surgical_profiles, :encrypted_hospital_admission_date, :string
    remove_column :surgical_profiles, :operation_date
    add_column :surgical_profiles, :encrypted_operation_date, :string

    change_table :surgical_profiles do |t|
      t.string :encrypted_hospital_admission_date_salt
      t.string :encrypted_hospital_admission_date_iv
      t.string :encrypted_operation_date_salt
      t.string :encrypted_operation_date_iv
    end
  end
end
