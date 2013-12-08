HealthProj.Views.Races ||= {}

class HealthProj.Views.Races.ShowView extends Backbone.View
  template: JST["backbone/templates/races/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
