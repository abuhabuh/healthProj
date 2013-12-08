HealthProj.Views.Countries ||= {}

class HealthProj.Views.Countries.CountryView extends Backbone.View
  template: JST["backbone/templates/countries/country"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
