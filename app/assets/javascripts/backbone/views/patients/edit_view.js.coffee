HealthProj.Views.Patients ||= {}

class HealthProj.Views.Patients.EditView extends Backbone.View
  template: JST["backbone/templates/patients/edit"]

  events:
    "submit #edit-patient" : "update"

  update: (e) ->
    # DOB is saved in DB as string; backend model handles transform
    #   between string and date object
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (patient) =>
        @model = patient
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
