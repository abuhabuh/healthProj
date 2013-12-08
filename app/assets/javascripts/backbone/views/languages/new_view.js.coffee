HealthProj.Views.Languages ||= {}

class HealthProj.Views.Languages.NewView extends Backbone.View
  template: JST["backbone/templates/languages/new"]

  events:
    "submit #new-language": "save"

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
      success: (language) =>
        @model = language
        window.location.hash = "/#{@model.id}"

      error: (language, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
