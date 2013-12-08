class HealthProj.Routers.LanguagesRouter extends Backbone.Router
  initialize: (options) ->
    @languages = new HealthProj.Collections.LanguagesCollection()
    @languages.reset options.languages

  routes:
    "new"      : "newLanguage"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newLanguage: ->
    @view = new HealthProj.Views.Languages.NewView(collection: @languages)
    $("#languages").html(@view.render().el)

  index: ->
    @view = new HealthProj.Views.Languages.IndexView(languages: @languages)
    $("#languages").html(@view.render().el)

  show: (id) ->
    language = @languages.get(id)

    @view = new HealthProj.Views.Languages.ShowView(model: language)
    $("#languages").html(@view.render().el)

  edit: (id) ->
    language = @languages.get(id)

    @view = new HealthProj.Views.Languages.EditView(model: language)
    $("#languages").html(@view.render().el)
