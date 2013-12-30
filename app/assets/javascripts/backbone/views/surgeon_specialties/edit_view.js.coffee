HealthProj.Views.SurgeonSpecialties ||= {}

class HealthProj.Views.SurgeonSpecialties.EditView extends Backbone.View
  template : JST["backbone/templates/surgeon_specialties/edit"]

  events :
    "submit #edit-surgeon_specialty" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (surgeon_specialty) =>
        @model = surgeon_specialty
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
