class HealthProj.Models.Language extends Backbone.Model
  paramRoot: 'language'

  defaults: {}

class HealthProj.Collections.LanguagesCollection extends Backbone.Collection
  model: HealthProj.Models.Language
  url: '/languages'
