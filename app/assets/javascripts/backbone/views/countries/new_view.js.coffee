HealthProj.Views.Countries ||= {}

class HealthProj.Views.Countries.NewView extends Backbone.View
  template: JST["backbone/templates/countries/new"]

  events:
    "submit #new-country": "save"

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
      success: (country) =>
        @model = country
        window.location.hash = "/#{@model.id}"

      error: (country, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
