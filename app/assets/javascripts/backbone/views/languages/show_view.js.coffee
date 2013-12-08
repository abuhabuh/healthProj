HealthProj.Views.Languages ||= {}

class HealthProj.Views.Languages.ShowView extends Backbone.View
  template: JST["backbone/templates/languages/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
