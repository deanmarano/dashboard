http = require 'http'
querystring = require 'querystring'
xml2js = require 'xml2js'

class GoodreadsUser
  constructor: (userXml, whenLoaded)->
    @xml = userXml
    @load(whenLoaded)

  id: ->
    @userData.id[0]

  load: (onResult)->
    onResult(@) if @data
    parser = new xml2js.Parser()
    parser.parseString @xml, (err, data) =>
      if err
        onResult(err)
      @data = data
      @userData = data.GoodreadsResponse.user[0]
      onResult(@)

class Goodreads
  constructor: (@settings)->

  getUser: (userId, onResult)->
    query = querystring.stringify
      key: @settings.key
      id: userId

    path = "#{@settings.userShowPath.replace(':id', userId)}?#{query}"
    url = "#{@settings.host}/#{path}"

    request = http.get url, (res)->
      console.log("Goodreads getUser: Response Code: " + res.statusCode)
      res.setEncoding('utf8');
      output = ''
      res.on 'data', (chunk)->
        output += chunk
      res.on 'end', ->
        new GoodreadsUser output, (user)->
          onResult(user)

    request.on 'error', (e)->
      console.log 'Got error: ' + e.message

module.exports = (settings)-> new Goodreads(settings)
