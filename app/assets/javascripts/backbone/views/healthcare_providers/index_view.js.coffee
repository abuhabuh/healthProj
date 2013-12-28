HealthProj.Views.HealthcareProviders ||= {}

class HealthProj.Views.HealthcareProviders.IndexView extends Backbone.View
  template: JST["backbone/templates/healthcare_providers/index"]

  initialize: () ->
    @options.healthcareProviders.bind('reset', @addAll)

  addAll: () =>
    @options.healthcareProviders.each(@addOne)

  addOne: (healthcareProvider) =>
    view = new HealthProj.Views.HealthcareProviders.HealthcareProviderView({model : healthcareProvider})
    @$(".healthcare-providers-list").append(view.render().el)

  render: =>
    $(@el).html(@template(healthcareProviders: @options.healthcareProviders.toJSON() ))
    @addAll()

    return this
