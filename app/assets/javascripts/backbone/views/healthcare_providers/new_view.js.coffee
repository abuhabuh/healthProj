HealthProj.Views.HealthcareProviders ||= {}

class HealthProj.Views.HealthcareProviders.NewView extends Backbone.View
  template: JST["backbone/templates/healthcare_providers/new"]

  events:
    "submit #new-healthcare_provider": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")
    @collection.create(@model.toJSON(),
      success: (healthcare_provider) =>
        @model = healthcare_provider
        window.location.hash = "/#{@model.id}"

      error: (healthcare_provider, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
