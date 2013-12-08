HealthProj.Views.Countries ||= {}

class HealthProj.Views.Countries.ShowView extends Backbone.View
  template: JST["backbone/templates/countries/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
