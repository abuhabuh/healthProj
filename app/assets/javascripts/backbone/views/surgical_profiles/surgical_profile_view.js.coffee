HealthProj.Views.SurgicalProfiles ||= {}

class HealthProj.Views.SurgicalProfiles.SurgicalProfileView extends Backbone.View
  template: JST["backbone/templates/surgical_profiles/surgical_profile"]

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
