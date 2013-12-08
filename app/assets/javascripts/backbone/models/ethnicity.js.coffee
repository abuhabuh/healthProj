class HealthProj.Models.Ethnicity extends Backbone.Model
  paramRoot: 'ethnicity'

  defaults:

class HealthProj.Collections.EthnicitiesCollection extends Backbone.Collection
  model: HealthProj.Models.Ethnicity
  url: '/ethnicities'
