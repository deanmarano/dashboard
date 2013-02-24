App.Views.CodeView = Backbone.View.extend
  toggle: ->
    if @$el.is(':visible')
      @$el.slideUp('slow')
    else
      @$el.slideDown('slow')
