class HealthProj.Routers.PatientsRouter extends Backbone.Router
  initialize: (options) ->
    @patients = new HealthProj.Collections.PatientsCollection()
    @patients.reset options.patients

  routes:
    "new"      : "newPatient"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newPatient: ->
    @view = new HealthProj.Views.Patients.NewView(collection: @patients)
    $("#patients").html(@view.render().el)

  index: ->
    @view = new HealthProj.Views.Patients.IndexView(patients: @patients)
    $("#patients").html(@view.render().el)

  show: (id) ->
    patient = @patients.get(id)

    @view = new HealthProj.Views.Patients.ShowView(model: patient)
    $("#patients").html(@view.render().el)

  edit: (id) ->
    patient = @patients.get(id)

    @view = new HealthProj.Views.Patients.EditView(model: patient)
    $("#patients").html(@view.render().el)
