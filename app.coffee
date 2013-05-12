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

app.get '/data/goodreads', routes.goodreads

app.get '/data/lastfm', routes.lastfm

app.get '/data/twitter', routes.twitter

app.get '/data/github', routes.github

app.listen(app.get('port'))
console.log("listening on port #{app.get('port')}")
