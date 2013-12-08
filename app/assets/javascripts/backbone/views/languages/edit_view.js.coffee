HealthProj.Views.Languages ||= {}

class HealthProj.Views.Languages.EditView extends Backbone.View
  template : JST["backbone/templates/languages/edit"]

  events :
    "submit #edit-language" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (language) =>
        @model = language
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
