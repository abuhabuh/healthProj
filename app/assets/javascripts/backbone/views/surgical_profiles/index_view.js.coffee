HealthProj.Views.SurgicalProfiles ||= {}

class HealthProj.Views.SurgicalProfiles.IndexView extends Backbone.View
  template: JST["backbone/templates/surgical_profiles/index"]

  initialize: () ->
    @options.surgicalProfiles.bind('reset', @addAll)

  addAll: () =>
    @options.surgicalProfiles.each(@addOne)

  addOne: (surgicalProfile) =>
    view = new HealthProj.Views.SurgicalProfiles.SurgicalProfileView({model : surgicalProfile})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(surgicalProfiles: @options.surgicalProfiles.toJSON() ))
    @addAll()

    return this
