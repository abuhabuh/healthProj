class HealthProj.Routers.HealthcareProvidersRouter extends Backbone.Router
  initialize: (options) ->
    @healthcareProviders = new HealthProj.Collections.HealthcareProvidersCollection()
    @healthcareProviders.reset options.healthcare_providers

  routes:
    "new"      : "newHealthcareProvider"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newHealthcareProvider: ->
    @view = new HealthProj.Views.HealthcareProviders.NewView(collection: @healthcareProviders)
    $("#healthcare_providers").html(@view.render().el)

  index: ->
    @view = new HealthProj.Views.HealthcareProviders.IndexView(healthcareProviders: @healthcareProviders)
    $("#healthcare_providers").html(@view.render().el)

  show: (id) ->
    healthcareProvider = @healthcareProviders.get(id)

    @view = new HealthProj.Views.HealthcareProviders.ShowView(model: healthcareProvider)
    $("#healthcare_providers").html(@view.render().el)

  edit: (id) ->
    healthcareProvider = @healthcareProviders.get(id)

    @view = new HealthProj.Views.HealthcareProviders.EditView(model: healthcareProvider)
    $("#healthcare_providers").html(@view.render().el)
