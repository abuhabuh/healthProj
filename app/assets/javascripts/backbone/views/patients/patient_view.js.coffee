HealthProj.Views.Patients ||= {}

class HealthProj.Views.Patients.PatientView extends Backbone.View
  template: JST["backbone/templates/patients/patient"]

  events:
    "click .destroy" : "destroy"
    "click .patient-main-hor" : "toggleDetailView"

  tagName: "div"
  className: "patient-container-hor"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this

  toggleDetailView: ->
    $(@el).children('.patient-detail-hor').toggle(150);
