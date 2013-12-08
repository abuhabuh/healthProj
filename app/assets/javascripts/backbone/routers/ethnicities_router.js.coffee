class HealthProj.Routers.EthnicitiesRouter extends Backbone.Router
  initialize: (options) ->
    @ethnicities = new HealthProj.Collections.EthnicitiesCollection()
    @ethnicities.reset options.ethnicities

  routes:
    "new"      : "newEthnicity"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newEthnicity: ->
    @view = new HealthProj.Views.Ethnicities.NewView(collection: @ethnicities)
    $("#ethnicities").html(@view.render().el)

  index: ->
    @view = new HealthProj.Views.Ethnicities.IndexView(ethnicities: @ethnicities)
    $("#ethnicities").html(@view.render().el)

  show: (id) ->
    ethnicity = @ethnicities.get(id)

    @view = new HealthProj.Views.Ethnicities.ShowView(model: ethnicity)
    $("#ethnicities").html(@view.render().el)

  edit: (id) ->
    ethnicity = @ethnicities.get(id)

    @view = new HealthProj.Views.Ethnicities.EditView(model: ethnicity)
    $("#ethnicities").html(@view.render().el)
