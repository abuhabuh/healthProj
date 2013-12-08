HealthProj.Views.Languages ||= {}

class HealthProj.Views.Languages.LanguageView extends Backbone.View
  template: JST["backbone/templates/languages/language"]

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
