window.App =
  Views: {}

App.Router = Backbone.Router.extend
  routes:
    "(/)": "index"
    "code(/)": "code"
    "books(/)": "books"

  index: ->
    @initialize()

  code: ->
    @initialize()
    @codeView ||= new App.Views.CodeView
      el: $('.code.more')
    @codeView.toggle()

  books: ->
    @initialize()
    $(".books .more").slideDown('slow')

  initialize: ->
    return if @initialized?
    $('a img').parent().click (e)->
      e.preventDefault()
      #$(".#{$(e.currentTarget).attr('href')}.more").slideDown('slow')
      App.router.navigate $(e.currentTarget).attr('href'), trigger: true
    @initialized = true

App.start = ->
  App.router = new App.Router
  Backbone.history.start(pushState: true)

  $trigger = $('#trigger')
  $hidden = $('#hidden')
  $trigger.on 'click', ->
    if $hidden.is(':visible')
      $hidden.slideUp(100)
    else
      $hidden.slideDown(100)

  $window = $(window)
  $window.scroll (e)->
    top = $window.scrollTop() / 1.5 + "px"
    $('img#background').css('top', top)
