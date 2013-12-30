class HealthProj.Routers.SurgeonSpecialtiesRouter extends Backbone.Router
  initialize: (options) ->
    @surgeonSpecialties = new HealthProj.Collections.SurgeonSpecialtiesCollection()
    @surgeonSpecialties.reset options.surgeonSpecialties

  routes:
    "new"      : "newSurgeonSpecialty"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newSurgeonSpecialty: ->
    @view = new HealthProj.Views.SurgeonSpecialties.NewView(collection: @surgeon_specialties)
    $("#surgeon_specialties").html(@view.render().el)

  index: ->
    @view = new HealthProj.Views.SurgeonSpecialties.IndexView(surgeon_specialties: @surgeon_specialties)
    $("#surgeon_specialties").html(@view.render().el)

  show: (id) ->
    surgeon_specialty = @surgeon_specialties.get(id)

    @view = new HealthProj.Views.SurgeonSpecialties.ShowView(model: surgeon_specialty)
    $("#surgeon_specialties").html(@view.render().el)

  edit: (id) ->
    surgeon_specialty = @surgeon_specialties.get(id)

    @view = new HealthProj.Views.SurgeonSpecialties.EditView(model: surgeon_specialty)
    $("#surgeon_specialties").html(@view.render().el)
