HealthProj.Views.Patients ||= {}

class HealthProj.Views.Patients.IndexView extends Backbone.View
  template: JST['backbone/templates/patients/index']

  tagName: 'div'
  className: 'patients-list-container-hor'

  initialize: () ->
    @options.patients.bind('reset', @addAll)

  addAll: () ->
    @options.patients.each(@addOne)

  addOne: (patient) =>
    view = new HealthProj.Views.Patients.PatientView({model : patient})
    this.$el.append(view.render().el)


  render: ->
    $(@el).html(@template(patients: @options.patients.toJSON()))
    @addAll()

    return this
