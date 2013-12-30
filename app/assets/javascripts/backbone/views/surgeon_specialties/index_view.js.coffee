HealthProj.Views.SurgeonSpecialties ||= {}

class HealthProj.Views.SurgeonSpecialties.IndexView extends Backbone.View
  template: JST["backbone/templates/surgeon_specialties/index"]

  initialize: () ->
    @options.surgeonSpecialties.bind('reset', @addAll)

  addAll: () =>
    @options.surgeonSpecialties.each(@addOne)

  addOne: (surgeonSpecialty) =>
    view = new HealthProj.Views.SurgeonSpecialties.SurgeonSpecialtyView({model : surgeonSpecialty})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(surgeonSpecialties: @options.surgeonSpecialties.toJSON() ))
    @addAll()

    return this
