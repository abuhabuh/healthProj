###
# Prefixing columns with 'encrypted_' and adding salt and IV columns
#   for each encrypted column
# Code change associated:
# - model.rb classes which maps new column names to old columns
# - Transformation function needs to be built to turn date into an 
#   encryptable string
###

class EncryptPatients < ActiveRecord::Migration
  def change
    # For Patients, need to change all types to string for encryption
    #   - medical_record_id
    #   - date_of_birth
    remove_column :patients, :medical_record_id
    add_column :patients, :encrypted_medical_record_id, :string
    remove_column :patients, :date_of_birth
    add_column :patients, :encrypted_date_of_birth, :string

    change_table :patients do |t|
      t.rename :last_name, :encrypted_last_name
      t.rename :first_name, :encrypted_first_name
      t.rename :middle_initial, :encrypted_middle_initial
      t.rename :address1, :encrypted_address1
      t.rename :address2, :encrypted_address2
      t.rename :city, :encrypted_city
      t.rename :state, :encrypted_state
      t.rename :home_phone, :encrypted_home_phone
      t.rename :work_phone, :encrypted_work_phone
      t.rename :cell_phone, :encrypted_cell_phone
      t.rename :gender, :encrypted_gender
      # Columns that are foreign keys into other tables are not
      #   renamed - :race_id, :ethnicity_id, :language_id

      # Add salt and IV columns for
      t.string :encrypted_medical_record_id_salt
      t.string :encrypted_medical_record_id_iv
      t.string :encrypted_date_of_birth_salt
      t.string :encrypted_date_of_birth_iv
      t.string :encrypted_last_name_salt
      t.string :encrypted_last_name_iv
      t.string :encrypted_first_name_salt
      t.string :encrypted_first_name_iv
      t.string :encrypted_middle_initial_salt
      t.string :encrypted_middle_initial_iv
      t.string :encrypted_address1_salt
      t.string :encrypted_address1_iv
      t.string :encrypted_address2_salt
      t.string :encrypted_address2_iv
      t.string :encrypted_city_salt
      t.string :encrypted_city_iv
      t.string :encrypted_state_salt
      t.string :encrypted_state_iv
      t.string :encrypted_home_phone_salt
      t.string :encrypted_home_phone_iv
      t.string :encrypted_work_phone_salt
      t.string :encrypted_work_phone_iv
      t.string :encrypted_cell_phone_salt
      t.string :encrypted_cell_phone_iv
      t.string :encrypted_gender_salt
      t.string :encrypted_gender_iv
    end

    change_table :ethnicities do |t|
      t.rename :name, :encrypted_name

      t.string :encrypted_name_salt
      t.string :encrypted_name_iv
    end

    change_table :races do |t|
      t.rename :name, :encrypted_name

      t.string :encrypted_name_salt
      t.string :encrypted_name_iv
    end

    change_table :languages do |t|
      t.rename :name, :encrypted_name
      # country_id foreign key column not encrypted. country table
      #   will either be encrypted or dropped by end of project

      t.string :encrypted_name_salt
      t.string :encrypted_name_iv
    end

  end
end
