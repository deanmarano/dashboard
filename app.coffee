express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'
coffeescript = require 'connect-coffee-script'
stylus = require 'stylus'

app = express()

app.configure ->
  app.set('port', process.env.PORT || 3000)
  app.set('views', __dirname + '/app/views')
  app.set('view engine', 'jade')
  app.use(express.favicon())
  app.use(express.logger('dev'))
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(express.cookieParser('your secret here'))
  app.use(express.session())
  app.use(app.router)

  app.use stylus.middleware
    src: __dirname + '/app/assets'
    dest: __dirname + '/public'

  app.use coffeescript
    src: __dirname + '/app/assets/coffee'
    dest: __dirname + '/public/js'
    prefix: '/js'

  app.use(express.static(path.join(__dirname, 'public')))
  app.use('/images', express.static(path.join(__dirname, 'app/assets/images')))

app.configure 'development', ->
  app.use(express.errorHandler())

app.get('/', routes.index)

settings = require './app/settings'

app.get '/data/goodreads', (req, res)->
  goodreads = require('./lib/goodreads') settings.goodreads
  shelfId = 21538062
  goodreads.getUser 6540398, (user)->
    goodreads.getShelfForUser user, 'read', (userWithShelves)->
      res.set('Content-Type', 'application/json')
      res.send userWithShelves

app.get '/data/lastfm', (req, res)->
  lastfm = require('./lib/lastfm') settings.lastfm
  lastfm.getRecentTracksForUser 'il1019', (trackListResponse)->
    res.set('Content-Type', 'application/json')
    res.send trackListResponse.body

app.get '/data/twitter', (req, res)->
  twitterClient = require('./lib/twitter') settings.twitter
  twitterClient.getRecentTweetsForUser 'pleiadeez', (tweetResponse)->
    res.set('Content-Type', 'application/json')
    res.send tweetResponse.body

app.get '/data/github', (req, res)->
  githubClient = require('./lib/github') settings.github
  githubClient.getRecentEventsForUser 'pleiadeez', (githubResponse)->
    res.set('Content-Type', 'application/json')
    res.send githubResponse.body

app.listen(app.get('port'))
console.log("listening on port #{app.get('port')}")
