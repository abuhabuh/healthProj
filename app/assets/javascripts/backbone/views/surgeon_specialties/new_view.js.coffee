HealthProj.Views.SurgeonSpecialties ||= {}

class HealthProj.Views.SurgeonSpecialties.NewView extends Backbone.View
  template: JST["backbone/templates/surgeon_specialties/new"]

  events:
    "submit #new-surgeon_specialty": "save"

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
      success: (surgeon_specialty) =>
        @model = surgeon_specialty
        window.location.hash = "/#{@model.id}"

      error: (surgeon_specialty, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
