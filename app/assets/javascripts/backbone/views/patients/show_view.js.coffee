HealthProj.Views.Patients ||= {}

class HealthProj.Views.Patients.ShowView extends Backbone.View
  template: JST["backbone/templates/patients/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
