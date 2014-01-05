class HealthProj.Models.Patient extends Backbone.Model
  paramRoot: 'patient'

  defaults: {}

  # Defines display parameters for database fields
  # - first key is database col name
  # - primary says whether or not to display field in abridged view
  # Usage: Patient.field_info['last_name']['primary']
  #
  # *** not used right now
  @fieldInfo: {
    'medical_record_id': {'primary': true, 'tab_ind': 1},
    'last_name': {'primary': true, 'tab_ind': 2},
    'first_name': {'primary': true, 'tab_ind': 3},
    'middle_initial': {'primary': true, 'tab_ind': 4},
    'address1': {'primary': false, 'tab_ind': 5},
    'address2': {'primary': false, 'tab_ind': 6},
    'city': {'primary': false, 'tab_ind': 7},
    'state': {'primary': false, 'tab_ind': 8},
    'home_phone': {'primary': false, 'tab_ind': 9},
    'work_phone': {'primary': false, 'tab_ind': 10},
    'cell_phone': {'primary': false, 'tab_ind': 11},
    'date_of_birth': {'primary': false, 'tab_ind': 12},
    'gender': {'primary': false, 'tab_ind': 13},
    'race': {'primary': false, 'tab_ind': 14},
    'ethnicity': {'primary': false, 'tab_ind': 15},
    'preferred_language': {'primary': false, 'tab_ind': 16}
  }

class HealthProj.Collections.PatientsCollection extends Backbone.Collection
  model: HealthProj.Models.Patient
  url: '/patients'
