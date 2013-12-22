class HealthProj.Models.Department extends Backbone.Model
  paramRoot: 'department'

  defaults:
    name: null
    healthcare_provider_id: null

class HealthProj.Collections.DepartmentsCollection extends Backbone.Collection
  model: HealthProj.Models.Department
  # TODO: url should not be set without a healthcare_provider defined
  #  pretty this up?
  url: '/wrongUrlDepartments'
