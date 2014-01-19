HealthProj.Views.HealthcareProviders ||= {}

# Health Provider view class
#
# - Renders Departments views as well
# - Initializes departments collection for the model if it doesn't exist

class HealthProj.Views.HealthcareProviders.ShowView extends Backbone.View
  template: JST["backbone/templates/healthcare_providers/show"]
  deptCollectionTemplate: JST["backbone/templates/departments/index"]

  events:
    "submit #add-department" : "handleDepartmentCreate"

  initialize: (options) ->
    if not @model.departments
      @model.departments = new HealthProj.Collections.DepartmentsCollection()
      @model.departments.url = '/healthcare_providers/' + @model.id + '/departments/'
    @_bindEventsOnDepartments()
    @model.departments.fetch()

  render: ->
    $(@el).html(@template(@model.toJSON()))
    return this

  handleDepartmentCreate: (e) ->
    e.preventDefault()
    e.stopPropagation()

    # add department to collection
    department = new HealthProj.Models.Department()

    $formEl = @$("#add-department")
    deptName = $formEl.find("#name").val()
    department.set({name: deptName}, {silent: true})
    department.set({healthcare_provider_id: @model.id}, {silent: true})

    # TODO: fix validation
    # department.on("invalid", @_setDeptValidationError)
    # set validation error action for department

    @model.departments.create(department.toJSON(),
      error: (department, response, options) =>
        # TODO: implement or delete this, used to have debug statement here
      wait: true
    )

  # Departments Collection change events
  _bindEventsOnDepartments: () ->
    @model.departments.on('reset', @_renderAllDepartments, this)
    @model.departments.on('add', @_addDepartment, this)

  _renderDepartmentContainer: () ->
    @$(".departments").html(@deptCollectionTemplate())

  _renderAllDepartments: () ->
    @_renderDepartmentContainer()
    @model.departments.each(@_addDepartment, this)

  _addDepartment: (newDept) ->
    departmentView = new HealthProj.Views.Departments.DepartmentView({model : newDept})
    @$(".departments-list-container").append(departmentView.render().el)

  _setDeptValidationError: (model, error) ->
    # TODO: implement or delete this: used to have debug statement here