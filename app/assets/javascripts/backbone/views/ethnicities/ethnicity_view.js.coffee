HealthProj.Views.Ethnicities ||= {}

class HealthProj.Views.Ethnicities.EthnicityView extends Backbone.View
  template: JST["backbone/templates/ethnicities/ethnicity"]

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
