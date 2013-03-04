App.Router = Backbone.Router.extend
  routes:
    "(/)": 'index'
    "code(/)": 'code'
    "music(/)": 'music'
    "books(/)": 'books'
    "twitter(/)": 'twitter'
    "facebook(/)": 'facebook'
    "starter-league(/)": 'starterLeague'
    "email(/)": 'email'

  index: ->
    console.log 'router: index'

  code: ->
    console.log 'router: code'
    App.getSection('code').showMore(delay: true)

  books: ->
    console.log 'router: books'
    App.getSection('books').expand()

  music: ->
    console.log 'router: music'
    App.getSection('music').expand()

  twitter: ->
    console.log 'router: twitter'
    App.getSection('twitter').expand()

  facebook: ->
    console.log 'router: facebook'
    App.getSection('facebook').showMore(delay: true)

  starterLeague: ->
    console.log 'router: starterLeague'
    App.getSection('starter-league').showMore(delay: true)

  email: ->
    console.log 'router: email'
    App.getSection('email').showMore(delay: true)
