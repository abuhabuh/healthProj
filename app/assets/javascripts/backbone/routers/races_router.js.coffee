class HealthProj.Routers.RacesRouter extends Backbone.Router
  initialize: (options) ->
    @races = new HealthProj.Collections.RacesCollection()
    @races.reset options.races

  routes:
    "new"      : "newRace"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newRace: ->
    @view = new HealthProj.Views.Races.NewView(collection: @races)
    $("#races").html(@view.render().el)

  index: ->
    @view = new HealthProj.Views.Races.IndexView(races: @races)
    $("#races").html(@view.render().el)

  show: (id) ->
    race = @races.get(id)

    @view = new HealthProj.Views.Races.ShowView(model: race)
    $("#races").html(@view.render().el)

  edit: (id) ->
    race = @races.get(id)

    @view = new HealthProj.Views.Races.EditView(model: race)
    $("#races").html(@view.render().el)
