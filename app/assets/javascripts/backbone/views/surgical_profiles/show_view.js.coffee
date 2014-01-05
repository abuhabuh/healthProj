HealthProj.Views.SurgicalProfiles ||= {}

class HealthProj.Views.SurgicalProfiles.ShowView extends Backbone.View
  template: JST["backbone/templates/surgical_profiles/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
