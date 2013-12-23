class HealthProj.Models.HealthcareProvider extends Backbone.Model
  paramRoot: 'healthcare_provider'

  defaults:
    name: null
    provider_type: null

  initialize: (options) ->

class HealthProj.Collections.HealthcareProvidersCollection extends Backbone.Collection
  model: HealthProj.Models.HealthcareProvider
  url: '/healthcare_providers'
