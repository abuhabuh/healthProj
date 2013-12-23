HealthProj.Views.Departments ||= {}

class HealthProj.Views.Departments.DepartmentView extends Backbone.View
  template: JST["backbone/templates/departments/department"]

  events:
    "click .destroy" : "destroy"

  tagName: "div"
  className: "department-element-hor"

  destroy: () ->
    @model.destroy()
    this.remove()
    return false

  render: () ->
    $(@el).html(@template(@model.toJSON()))
    return this
