##
# Surgical Profile
#
# Enumerated fields
# - fields are: patient_status, elective_surgery_option, origin_status,
#     anesthesia_technique
# - represented as integers [0 to n-1] in database and mapped to strings
#
# DB Table
# - Encrypted Fields
#   - hospital_admission_date
#   - operation_date
##

class SurgicalProfile < ActiveRecord::Base

  include EncryptionKey

  belongs_to :patient
  belongs_to :user
  has_one :preop_risk_assessment

  # Encryption
  attr_encrypted :hospital_admission_date, :key => :encryption_key
  attr_encrypted :operation_date, :key => :encryption_key

  # Static class variables
  # TODO: make interaction with this more graceful? Reduce hard coding
  @@PATIENT_STATUSES = %w(Inpatient Outpatient)
  @@ELECTIVE_SURGERY_OPTIONS = %w(Yes No Unknown)
  @@ORIGIN_STATUSES = [
    'Not Transferred, DA from home',
    'Acute Care Facility (in-patient)',
    'Nursing Home/ Chronic Care/Intermediate care',
    'Transfer from Other',
    'Transfer from outside ER',
    'Unknown'
    ]
  @@ANESTHESIA_TECHNIQUES = [
    'General',
    'Spinal',
    'Epidural',
    'Regional',
    'Local',
    'MAC/IV Sedation',
    'None',
    'Other',
    'Unknown'
    ]
  ####
  # Validations
  ####

  ####
  # Static methods
  ####

  # return all surgical profiles that belong to surgeon
  def self.query_all_by_surgeon(surgeon)
    return SurgicalProfile.where(user: surgeon)
  end

  def self.query_all_by_surgeon_inc_patients(surgeon)
    return SurgicalProfile.where(user: surgeon).includes(:patient)
  end

  # Returns all surgical profiles associated with patient
  def self.query_all_by_patient_id(surgeon, patient_id)
    if surgeon.is_admin()
      return SurgicalProfile.where(
        surgical_profiles: {patient_id: patient_id}
        )
    else
      surgical_profiles =
        SurgicalProfile.where(surgical_profiles: {user_id: surgeon.id})
                       .where(surgical_profiles: {patient_id: patient_id})
      return surgical_profiles
    end
  end

  def self.query_all_by_patient_id_inc_patients(surgeon, patient_id)
    if surgeon.is_admin()
      return SurgicalProfile.where(
                surgical_profiles: {patient_id: patient_id})
              .includes(:patient)

    else
      surgical_profiles =
        SurgicalProfile.where(surgical_profiles: {user_id: surgeon.id})
                       .where(surgical_profiles: {patient_id: patient_id})
                       .includes(:patient)
      return surgical_profiles
    end
  end

  # Returns surgical profile if it's viewable by current signed in user
  # Exception is raised if not viewable
  def self.query_one_by_id(surgeon, surgical_profile_id)
    if surgeon.is_admin()
      return SurgicalProfile.find(surgical_profile_id)
    else
      surgical_profile =
        SurgicalProfile.where(surgical_profiles: {id: surgical_profile_id})
                       .where(surgical_profiles: {user_id: surgeon.id})
                       .first
      if surgical_profile.nil?
        raise CanCan::AccessDenied.new(
          "Not authorized to view this surgical profile data!",
          :read,
          SurgicalProfile
          )
      end
      return surgical_profile
    end
  end

  # return static constants arrays
  def self.get_patient_statuses
    return @@PATIENT_STATUSES
  end

  def self.get_elective_surgery_options
    return @@ELECTIVE_SURGERY_OPTIONS
  end

  def self.get_origin_statuses
    return @@ORIGIN_STATUSES
  end

  def self.get_anesthesia_techniques
    return @@ANESTHESIA_TECHNIQUES
  end

  def self.get_patient_status_by_index(index)
    if index.between?(0, @@PATIENT_STATUSES.length - 1)
      return @@PATIENT_STATUSES[index]
    end
    return ''
  end

  def self.get_elective_surgery_option_by_index(index)
    if index.between?(0, @@ELECTIVE_SURGERY_OPTIONS.length - 1)
      return @@ELECTIVE_SURGERY_OPTIONS[index]
    end
    return ''
  end

  def self.get_origin_status_by_index(index)
    if index.between?(0, @@ORIGIN_STATUSES.length - 1)
      return @@ORIGIN_STATUSES[index]
    end
    return ''
  end

  def self.get_anesthesia_technique_by_index(index)
    if index.between?(0, @@ANESTHESIA_TECHNIQUES.length - 1)
      return @@ANESTHESIA_TECHNIQUES[index]
    end
    return ''
  end

  # return static constant nested arrays for selector that includes
  #   select option value and text
  # - [[Inpatient ,0], [Outpatient, 1] -> text is mapped to index
  #   in the static constants array
  def self.get_patient_statuses_select
    return self.get_patient_statuses.map.with_index{|x,i| [x,i]}
  end

  def self.get_elective_surgery_options_select
    return self.get_elective_surgery_options.map.with_index{|x,i| [x,i]}
  end

  def self.get_origin_statuses_select
    return self.get_origin_statuses.map.with_index{|x,i| [x,i]}
  end

  def self.get_anesthesia_techniques_select
    return self.get_anesthesia_techniques.map.with_index{|x,i| [x,i]}
  end

  ####
  # Instance methods
  ####

  # Wrapper for save function that transforms date attributes to
  #   string for encryption
  def preprocess_and_save
    process_attrs_before_write(self)
    return self.save()
  end

  # Wrapper for update function that transforms date attributes to
  #   string for encryption
  def preprocess_and_update(surgical_profile_params)
    process_attrs_before_write_params(surgical_profile_params)
    puts "@@@@"
    puts surgical_profile_params
    return self.update(surgical_profile_params)
  end


  private
    ###
    # Instance methods
    ###

    # Convert certain attrs for write to DB (due to encryption needs)
    def process_attrs_before_write(surgical_profile)
      if surgical_profile.hospital_admission_date
        surgical_profile.hospital_admission_date =
          surgical_profile.hospital_admission_date.to_s
      end
      if surgical_profile.operation_date
        surgical_profile.operation_date =
          surgical_profile.operation_date.to_s
      end
    end

    # Convert certain attrs for write to DB (due to encryption needs)
    def process_attrs_before_write_params(surgical_profile_params)
      if surgical_profile_params[:hospital_admission_date].present?
        surgical_profile_params[:hospital_admission_date] =
          surgical_profile_params[:hospital_admission_date].to_s
      end
      if surgical_profile_params[:operation_date].present?
        surgical_profile_params[:operation_date] =
          surgical_profile_params[:operation_date].to_s
      end
    end

end
