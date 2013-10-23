http = require 'http'
https = require 'https'
querystring = require 'querystring'
xml2js = require 'xml2js'
fs = require 'fs'

class BaseClient
  constructor: (@url, params = {})->
    if params?
      query = querystring.stringify params
      @url += "?" + query

  parseHeaders: (res) ->
    contentType = res.headers['content-type']
    headerData = contentType.split(';')
    {
      contentType: headerData[0]
      encoding: headerData[1].replace('charset=', '').trim()
    }

  log: (url, response)->
    url = url.replace(/\//g, '_')
    console.log "the url is #{url}"
    fs.writeFile "fixtures/#{url}", JSON.stringify(response), (err) ->
      if err
        console.log(err)
      else
        console.log("The file was saved!")

  get: (callback)->
    if true
      fs.readFile "fixtures/#{@url.replace(/\//g, '_')}", (err, data) ->
        callback(JSON.parse(data))
      return

    output = ''
    client = @
    protocol = if @url.match /^https:\/\// then https else http
    request = protocol.get @url, (res)=>
      log = @log
      url = @url
      console.log("URL: #{url}")
      console.log("Response Code: #{res.statusCode}")
      headers = @parseHeaders(res)
      console.log headers
      res.setEncoding headers.encoding
      res.on 'data', (chunk)->
        output += chunk
      res.on 'end', ->
        if headers.contentType == 'application/xml'
          client.parseXml output, (parsedXml)->
            response =
              code: res.statusCode
              body: parsedXml
            log(url, response)
            callback(response)
        else if headers.contentType == 'application/json'
          response =
            code: res.statusCode
            body: JSON.parse(output)
          log(url, response)
          callback(response)
        else
          response =
            code: res.statusCode
            body: JSON.parse(output)
          log(url, response)
          callback(response)

    request.on 'error', (e)->
      callback
        code: -1
        body: output
        exception: e.message

  parseXml: (xml, callback)->
    parser = new xml2js.Parser()
    parser.parseString xml, (err, data) =>
      if err?
        callback(xml)
      else
        callback(data)

module.exports = BaseClient
