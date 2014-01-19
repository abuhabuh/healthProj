class HealthProj.Models.Patient extends Backbone.Model
  paramRoot: 'patient'

  defaults: {}

  # Defines display parameters for database fields
  # - first key is database col name
  # - primary says whether or not to display field in abridged view
  # Usage: Patient.field_info['last_name']['primary']
  #
  # *** not used right now

class HealthProj.Collections.PatientsCollection extends Backbone.Collection
  model: HealthProj.Models.Patient
  url: '/patients'
