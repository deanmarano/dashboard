window.App = {}
App.Router = Backbone.Router.extend
  routes:
    "(/)": "index"
    "help":                 "help"    #help
    "search/:query":        "search"  #search/kiwis
    "search/:query/p:page": "search"   #search/kiwis/p7

  index: ->
    $('a img').parent().click (e)->
      e.preventDefault()
      App.router.navigate $(e.currentTarget).attr('href')

  help: ->

  search: (query, page)->

$ ->
  App.router = new App.Router
  Backbone.history.start(pushState: true)
