HealthProj.Views.SurgeonSpecialties ||= {}

class HealthProj.Views.SurgeonSpecialties.SurgeonSpecialtyView extends Backbone.View
  template: JST["backbone/templates/surgeon_specialties/surgeon_specialty"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
