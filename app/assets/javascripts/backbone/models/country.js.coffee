class HealthProj.Models.Country extends Backbone.Model
  paramRoot: 'country'

  defaults:

class HealthProj.Collections.CountriesCollection extends Backbone.Collection
  model: HealthProj.Models.Country
  url: '/countries'
