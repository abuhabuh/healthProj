HealthProj.Views.Patients ||= {}

class HealthProj.Views.Patients.ShowView extends Backbone.View
  template: JST["backbone/templates/patients/patient"]

  tagName: 'div'
  className: 'patient-container-hor'

  render: ->
    templateVars = @model.toJSON()
    templateVars['show_single'] = true

    $(@el).html(@template(templateVars))
    return this
