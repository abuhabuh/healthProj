HealthProj.Views.HealthcareProviders ||= {}

class HealthProj.Views.HealthcareProviders.HealthcareProviderView extends Backbone.View
  template: JST["backbone/templates/healthcare_providers/healthcare_provider"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
