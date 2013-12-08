HealthProj.Views.Ethnicities ||= {}

class HealthProj.Views.Ethnicities.IndexView extends Backbone.View
  template: JST["backbone/templates/ethnicities/index"]

  initialize: () ->
    @options.ethnicities.bind('reset', @addAll)

  addAll: () =>
    @options.ethnicities.each(@addOne)

  addOne: (ethnicity) =>
    view = new HealthProj.Views.Ethnicities.EthnicityView({model : ethnicity})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(ethnicities: @options.ethnicities.toJSON() ))
    @addAll()

    return this
