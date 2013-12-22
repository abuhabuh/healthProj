HealthProj.Views.HealthcareProviders ||= {}


# Health Provider view class
# - renders Departments views as well

class HealthProj.Views.HealthcareProviders.ShowView extends Backbone.View
  template: JST["backbone/templates/healthcare_providers/show"]
  deptTemplate: JST["backbone/templates/departments/department"]
  deptCollectionTemplate: JST["backbone/templates/departments/index"]

  events:
    "submit #add-department" : "handleDepartmentCreate"

  initialize: (options) ->
    @model.departments.fetch()
    @model.departments.on('reset', @_renderAllDepartments, this)
    @model.departments.on('add', @_addDepartment, this)
    @model.departments.on('remove', @_addDepartment, this)

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this

  handleDepartmentCreate: ->
    debugger;
    department = new HealthProj.Models.Department()
    department.set("name", "tom")
    department.set("healthcare_provider_id", @model.id)
    department.save(null,
      success: (department) =>
        alert("saved");
        window.location.hash = "/#{@model.id}"
    )

  # Departments Collection change events
  _renderAllDepartments: () ->
    debugger
    @$(".departments").html(@deptCollectionTemplate())
    @model.departments.each(@_addDepartment, this)

  _addDepartment: (newDept) ->
    debugger
    @$(".departments-list-container-hor").append(@deptTemplate(newDept.toJSON()))

  _removeDepartment: (removedDept, deptCollection, options) ->
    debugger


