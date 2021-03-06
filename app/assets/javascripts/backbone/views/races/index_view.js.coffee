HealthProj.Views.Races ||= {}

class HealthProj.Views.Races.IndexView extends Backbone.View
  template: JST["backbone/templates/races/index"]

  initialize: () ->
    @options.races.bind('reset', @addAll)

  addAll: () =>
    @options.races.each(@addOne)

  addOne: (race) =>
    view = new HealthProj.Views.Races.RaceView({model : race})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(races: @options.races.toJSON() ))
    @addAll()

    return this
