class HealthProj.Models.SurgicalProfile extends Backbone.Model
  paramRoot: 'surgical_profile'

  defaults:
    patient_status: null
    elective_surgery: null
    principal_procedure: null
    cpt_code: null
    origin_status: null
    hospital_admission_date: null
    operation_date: null
    anesthesia_technique: null
    encounter_number: null
    patient_id: null

class HealthProj.Collections.SurgicalProfilesCollection extends Backbone.Collection
  model: HealthProj.Models.SurgicalProfile
  url: '/surgical_profiles'
