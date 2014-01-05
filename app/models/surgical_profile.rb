##
# Surgical Profile
#
# Enumerated fields
# - fields are: patient_status, elective_surgery_option, origin_status,
#     anesthesia_technique
# - represented as integers [0 to n-1] in database and mapped to strings
##

class SurgicalProfile < ActiveRecord::Base

  # Static class variables
  # TODO: make interaction with this more graceful? Reduce hard coding
  @@PATIENT_STATUSES = %w(Inpatient Outpatient)
  @@ELECTIVE_SURGERY_OPTIONS = %w(Yes No Unknown)
  @@ORIGIN_STATUSES = ['Not Transferred, DA from home', 
                       'Acute Care Facility (in-patient)',
                       'Nursing Home/ Chronic Care/Intermediate care',
                       'Transfer from Other',
                       'Transfer from outside ER',
                       'Unknown'
                      ]
  @@ANESTHESIA_TECHNIQUES = ['General',
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

  # return static constant nested arrays for selector that includes
  #   select option value and text
  # - [[0, Inpatient], [1, Outpatient]] -> text is mapped to index
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
