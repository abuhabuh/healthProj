HealthProj.Views.Patients ||= {}

class HealthProj.Views.Patients.IndexView extends Backbone.View
  template: JST["backbone/templates/patients/index"]

  initialize: () ->
    @options.patients.bind('reset', @addAll)

  addAll: () =>
    debugger
    @options.patients.each(@addOne)

  addOne: (patient) =>
    debugger
    view = new HealthProj.Views.Patients.PatientView({model : patient})
    @$(".patients-list-container-hor").append(view.render().el)

  render: =>
    $(@el).html(@template(patients: @options.patients.toJSON()))
    @addAll()

    return this
