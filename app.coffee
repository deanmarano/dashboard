express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'
cs = require 'coffee-script'
coffeescript = require 'connect-coffee-script'

app = express()

app.configure ->
  app.set('port', process.env.PORT || 3000)
  app.set('views', __dirname + '/views')
  app.set('view engine', 'jade')
  app.use(express.favicon())
  app.use(express.logger('dev'))
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(express.cookieParser('your secret here'))
  app.use(express.session())
  app.use(app.router)
  app.use require('stylus').middleware(
    force: true
    src: __dirname + '/app/assets'
    dest: __dirname + '/public'
  )
  app.use coffeescript
    src: __dirname + '/app/assets/coffee'
    dest: __dirname + '/public/js'
  app.use(express.static(path.join(__dirname, 'public')))

app.configure 'development', ->
  app.use(express.errorHandler())

#app.get('/', routes.index)
app.get('/', routes.index2)
app.get('/code', routes.index2)
app.get('/books', routes.index2)

app.get '/data/goodreads', (req, res)->
  settings = require './app/settings'
  goodreads = require('./lib/goodreads') settings.goodreads
  shelfId = 21538062
  goodreads.getUser 6540398, (user)->
    #res.set('Content-Type', 'application/json')
    #res.send(user.userData)
    #goodreads.getShelvesForUser user, (userWithShelves)->
      #res.set('Content-Type', 'application/json')
      #res.send
        #book: userWithShelves.book(0)
        #user: user
    goodreads.getShelfForUser user, 'read', (userWithShelves)->
      res.set('Content-Type', 'application/json')
      res.send userWithShelves

app.listen(3000)
console.log('listening on port 3000')
