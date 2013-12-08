HealthProj.Views.Languages ||= {}

class HealthProj.Views.Languages.IndexView extends Backbone.View
  template: JST["backbone/templates/languages/index"]

  initialize: () ->
    @options.languages.bind('reset', @addAll)

  addAll: () =>
    @options.languages.each(@addOne)

  addOne: (language) =>
    view = new HealthProj.Views.Languages.LanguageView({model : language})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(languages: @options.languages.toJSON() ))
    @addAll()

    return this
