class HealthProj.Models.SurgeonSpecialty extends Backbone.Model
  paramRoot: 'surgeon_specialty'

  defaults:
    name: null

class HealthProj.Collections.SurgeonSpecialtiesCollection extends Backbone.Collection
  model: HealthProj.Models.SurgeonSpecialty
  url: '/surgeon_specialties'
