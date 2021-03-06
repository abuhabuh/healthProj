HealthProj.Views.Patients ||= {}

class HealthProj.Views.Patients.NewView extends Backbone.View
  template: JST["backbone/templates/patients/new"]

  events:
    "submit #new-patient": "save"

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
      success: (patient) =>
        @model = patient
        window.location.hash = "/#{@model.id}"

      error: (patient, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
