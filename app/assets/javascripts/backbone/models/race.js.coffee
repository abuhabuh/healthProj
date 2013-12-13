class HealthProj.Models.Race extends Backbone.Model
  paramRoot: 'race'

  defaults: {}

class HealthProj.Collections.RacesCollection extends Backbone.Collection
  model: HealthProj.Models.Race
  url: '/races'
