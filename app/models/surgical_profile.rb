##
# Surgical Profile
#
# Enumerated fields
# - fields are: patient_status, elective_surgery_option, origin_status,
#     anesthesia_technique
# - represented as integers [0 to n-1] in database and mapped to strings
##

class SurgicalProfile < ActiveRecord::Base
  belongs_to :patient
  belongs_to :user

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
  def self.query_surgical_profiles_by_surgeon(user)
    SurgicalProfile.where(user: user)
  end

  # Returns all surgical profiles associated with patient
  def self.query_surgical_profiles_by_patient(current_user, patient_id)
    if current_user.is_admin()
      return SurgicalProfile.where(
        surgical_profiles: {patient_id: patient_id}
        )
    else
      surgical_profiles =
        SurgicalProfile.where(surgical_profiles: {user_id: current_user.id})
                       .where(surgical_profiles: {patient_id: patient_id})
      return surgical_profiles
    end
  end

  # Returns surgical profile if it's viewable by current signed in user
  # Exception is raised if not viewable
  def self.query_surgical_profile_by_id(current_user, surgical_profile_id)
    if current_user.is_admin()
      return SurgicalProfile.find(surgical_profile_id)
    else
      surgical_profile =
        SurgicalProfile.where(surgical_profiles: {id: surgical_profile_id})
                       .where(surgical_profiles: {user_id: current_user.id})
                       .first
      if surgical_profile.nil?
        raise CanCan::AccessDenied.new(
          "Not authorized to view this surgical profile data!", :read, SurgicalProfile
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

  # Returns string representation of patient_status
  def get_patient_status_string
    return @@PATIENT_STATUSES[patient_status]
  end

end
