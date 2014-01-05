HealthProj.Views.SurgicalProfiles ||= {}

class HealthProj.Views.SurgicalProfiles.NewView extends Backbone.View
  template: JST["backbone/templates/surgical_profiles/new"]

  events:
    "submit #new-surgical_profile": "save"

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
      success: (surgical_profile) =>
        @model = surgical_profile
        window.location.hash = "/#{@model.id}"

      error: (surgical_profile, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
