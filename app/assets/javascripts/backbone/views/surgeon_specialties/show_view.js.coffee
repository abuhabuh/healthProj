HealthProj.Views.SurgeonSpecialties ||= {}

class HealthProj.Views.SurgeonSpecialties.ShowView extends Backbone.View
  template: JST["backbone/templates/surgeon_specialties/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
