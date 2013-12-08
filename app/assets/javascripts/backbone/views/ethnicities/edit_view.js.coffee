HealthProj.Views.Ethnicities ||= {}

class HealthProj.Views.Ethnicities.EditView extends Backbone.View
  template : JST["backbone/templates/ethnicities/edit"]

  events :
    "submit #edit-ethnicity" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (ethnicity) =>
        @model = ethnicity
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
