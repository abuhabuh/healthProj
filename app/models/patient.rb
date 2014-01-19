###
# Patients class
#
# DB Table
# - Most fields encrypted - db column names:
#   - encrypted_medical_record_id
#   - encrypted_date_of_birth
#   - encrypted_last_name
#   - encrypted_first_name
#   - encrypted_middle_initial
#   - encrypted_address1
#   - encrypted_address2
#   - encrypted_city
#   - encrypted_state
#   - encrypted_home_phone
#   - encrypted_work_phone
#   - encrypted_cell_phone
#   - encrypted_gender
# - Foreign key references to :race_id, :ethnicity_id,
#   :language_id not encrypted, but referenced tables are
###

class Patient < ActiveRecord::Base
  has_many :surgical_profiles, dependent: :destroy
  belongs_to :race
  belongs_to :ethnicity
  belongs_to :language

  # Static class variables
  @@ENUM_SEX = %w(male female)

  # Encryption
  attr_encrypted :medical_record_id, :key => 'blah_key'
  attr_encrypted :date_of_birth, :key => 'blah_key'
  attr_encrypted :last_name, :key => 'blah_key'
  attr_encrypted :first_name, :key => 'blah_key'
  attr_encrypted :middle_initial, :key => 'blah_key'
  attr_encrypted :address1, :key => 'blah_key'
  attr_encrypted :address2, :key => 'blah_key'
  attr_encrypted :city, :key => 'blah_key'
  attr_encrypted :state, :key => 'blah_key'
  attr_encrypted :home_phone, :key => 'blah_key'
  attr_encrypted :work_phone, :key => 'blah_key'
  attr_encrypted :cell_phone, :key => 'blah_key'
  attr_encrypted :gender, :key => 'blah_key'

  # Validation
  validates_inclusion_of :gender, :in => @@ENUM_SEX
end
