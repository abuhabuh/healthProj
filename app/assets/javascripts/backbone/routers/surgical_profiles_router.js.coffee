class HealthProj.Routers.SurgicalProfilesRouter extends Backbone.Router
  initialize: (options) ->
    @surgicalProfiles = new HealthProj.Collections.SurgicalProfilesCollection()
    @surgicalProfiles.reset options.surgicalProfiles

  routes:
    "new"      : "newSurgicalProfile"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newSurgicalProfile: ->
    @view = new HealthProj.Views.SurgicalProfiles.NewView(collection: @surgical_profiles)
    $("#surgical_profiles").html(@view.render().el)

  index: ->
    @view = new HealthProj.Views.SurgicalProfiles.IndexView(surgical_profiles: @surgical_profiles)
    $("#surgical_profiles").html(@view.render().el)

  show: (id) ->
    surgical_profile = @surgical_profiles.get(id)

    @view = new HealthProj.Views.SurgicalProfiles.ShowView(model: surgical_profile)
    $("#surgical_profiles").html(@view.render().el)

  edit: (id) ->
    surgical_profile = @surgical_profiles.get(id)

    @view = new HealthProj.Views.SurgicalProfiles.EditView(model: surgical_profile)
    $("#surgical_profiles").html(@view.render().el)
