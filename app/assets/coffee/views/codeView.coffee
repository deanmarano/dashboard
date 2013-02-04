App.Views.CodeView = Backbone.View.extend
  toggle: ->
    debugger
    if @$el.is(':visible')
      @$el.sideUp('slow')
    else
      @$el.slideDown('slow')
