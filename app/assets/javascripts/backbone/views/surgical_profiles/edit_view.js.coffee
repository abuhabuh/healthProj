HealthProj.Views.SurgicalProfiles ||= {}

class HealthProj.Views.SurgicalProfiles.EditView extends Backbone.View
  template : JST["backbone/templates/surgical_profiles/edit"]

  events :
    "submit #edit-surgical_profile" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (surgical_profile) =>
        @model = surgical_profile
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
