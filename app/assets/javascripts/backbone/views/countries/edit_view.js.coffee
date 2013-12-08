HealthProj.Views.Countries ||= {}

class HealthProj.Views.Countries.EditView extends Backbone.View
  template : JST["backbone/templates/countries/edit"]

  events :
    "submit #edit-country" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (country) =>
        @model = country
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
