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
#
# Special Notes
# - Date of birth stored as encrypted string in DB; model handles
#   transformation from string to date object and vice versa
#   - Wrappers used for save and update functions to handle
#     transformation
###

include ApplicationHelper

class Patient < ActiveRecord::Base

  include EncryptionKey

  has_many :surgical_profiles, dependent: :destroy
  belongs_to :race
  belongs_to :ethnicity
  belongs_to :language

  # Static class variables
  @@ENUM_SEX = %w(male female)

  # Encryption
  attr_encrypted :medical_record_id, :key => :encryption_key
  attr_encrypted :date_of_birth, :key => :encryption_key
  attr_encrypted :last_name, :key => :encryption_key
  attr_encrypted :first_name, :key => :encryption_key
  attr_encrypted :middle_initial, :key => :encryption_key
  attr_encrypted :address1, :key => :encryption_key
  attr_encrypted :address2, :key => :encryption_key
  attr_encrypted :city, :key => :encryption_key
  attr_encrypted :state, :key => :encryption_key
  attr_encrypted :home_phone, :key => :encryption_key
  attr_encrypted :work_phone, :key => :encryption_key
  attr_encrypted :cell_phone, :key => :encryption_key
  attr_encrypted :gender, :key => :encryption_key

  # Validation
  validates_inclusion_of :gender, :in => @@ENUM_SEX

  ###
  # Static methods
  ###

  # Returns patients viewable by current signed in user
  # TEST - http://localhost:3000/patients
  def self.query_all_patients(current_user)
    if current_user.is_admin()
      patients = Patient.all
    else
      patients = Patient.joins(:surgical_profiles)
                        .where(surgical_profiles: {user_id: current_user.id})
    end

    self.process_attrs_after_read_batch(patients)
    return patients
  end

  # Returns patient if it's viewable by current signed in user
  # Exception is raised if not viewable
  def self.query_patient_by_id(current_user, patient_id)
    if current_user.is_admin()
      patient = Patient.find(patient_id)
    else
      patient = Patient.joins(:surgical_profiles)
                       .where(patients: {id: patient_id})
                       .where(surgical_profiles: {user_id: current_user.id})
                       .first
      if patient.nil?
        raise CanCan::AccessDenied.new(
          "Not authorized to view this patient's data!", :read, Patient
          )
      end
    end

    self.process_attrs_after_read_single(patient)
    return patient
  end


  ###
  # Instance methods
  ###

  # Returns surgical profiles viewable by current signed in user
  # TEST - http://localhost:3000/patients/17/surgical_profiles
  def query_surgical_profiles(current_user)
    return SurgicalProfile.query_surgical_profiles_by_patient(
      current_user, self.id
      )
  end

  # Wrapper for save function that transforms date attribute to
  #   string for encryption
  def preprocess_and_save
    process_attrs_before_write(self)
    return self.save()
  end

  # Wrapper for update function that transforms date attribute to
  #   string for encryption
  def preprocess_and_update(patient_params)
    process_attrs_before_write_params(patient_params)
    return self.update(patient_params)
  end


  private
    ###
    # Static methods
    ###

    # Convert certain attrs after read from DB (due to encryption needs)
    def self.process_attrs_after_read_single(patient)
      if patient.date_of_birth
        patient.date_of_birth = Date.parse(patient.date_of_birth)
      end
    end

    # Convert certain attrs after read from DB (due to encryption needs)
    def self.process_attrs_after_read_batch(patients)
      patients.each do |patient|
        self.process_attrs_after_read_single(patient)
      end
    end

    ###
    # Instance methods
    ###

    # Convert certain attrs for write to DB (due to encryption needs)
    def process_attrs_before_write(patient)
      if patient.date_of_birth
        patient.date_of_birth = patient.date_of_birth.to_s
      end
    end

    # Convert certain attrs for write to DB (due to encryption needs)
    def process_attrs_before_write_params(patient_params)
      if patient_params[:date_of_birth].present?
        patient_params[:date_of_birth] = patient_params[:date_of_birth].to_s
      end
    end

end
