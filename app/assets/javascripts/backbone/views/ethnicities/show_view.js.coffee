HealthProj.Views.Ethnicities ||= {}

class HealthProj.Views.Ethnicities.ShowView extends Backbone.View
  template: JST["backbone/templates/ethnicities/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
