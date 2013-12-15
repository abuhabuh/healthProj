HealthProj.Views.HealthcareProviders ||= {}

class HealthProj.Views.HealthcareProviders.ShowView extends Backbone.View
  template: JST["backbone/templates/healthcare_providers/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
