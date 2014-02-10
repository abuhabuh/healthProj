###
# Patients class
#
# IMPORTANT:
# - Patient data access MUST be controlled by current_user access
#   privilege: current_user must be a surgeon and must be assigned
#   to one of patient's surgical profile
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

  @@RESULTS_LIMIT=10

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
  # Paginates as set by limit parameter (paginated)
  def self.query_all_patients(current_user, page=1, limit=@@RESULTS_LIMIT)
    if current_user.is_admin()
      patients = Patient.paginate(:page => page, :per_page => limit)
    elsif current_user.is_surgeon()
      patients = Patient.joins(:surgical_profiles)
                        .where(surgical_profiles: {user_id: current_user.id})
                        .paginate(:page => page, :per_page => limit)
    end

    self.process_attrs_after_read_batch(patients)
    return patients
  end

  # Returns patient if it's viewable by current signed in user
  # Exception is raised if not viewable
  def self.query_one_by_id(current_user, patient_id)
    if current_user.is_admin()
      patient = Patient.find(patient_id)
    elsif current_user.is_surgeon()
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
  def query_surgical_profiles_inc_patients(
      current_user, page=1, limit=@@RESULTS_LIMIT)
    return SurgicalProfile.query_all_by_patient_id_inc_patients(
      current_user, self.id, page, limit
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

  # TODO: Check if this accounts for leap years
  def age
    if self.date_of_birth
      now = Time.now.utc.to_date
      age = now.year - self.date_of_birth.year
        - (self.date_of_birth.to_date.change(:year => now.year) > now ? 1 : 0)
      return age
    end

    return 0
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
