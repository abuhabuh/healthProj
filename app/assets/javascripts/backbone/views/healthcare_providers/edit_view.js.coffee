HealthProj.Views.HealthcareProviders ||= {}

class HealthProj.Views.HealthcareProviders.EditView extends Backbone.View
  template: JST["backbone/templates/healthcare_providers/edit"]

  events:
    "submit #edit-healthcare_provider" : "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (healthcareProvider) =>
        @model = healthcareProvider
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
