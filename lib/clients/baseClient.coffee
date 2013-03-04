http = require 'http'
https = require 'https'
xml2js = require 'xml2js'

class BaseClient
  constructor: (@url, params = {})->

  parseHeaders: (res)->
    contentType = res.headers['content-type']
    headerData = contentType.split(';')
    {
      contentType: headerData[0]
      encoding: headerData[1].replace('charset=', '').trim()
    }

  get: (callback)->
    output = ''
    client = @
    protocol = if @url.match /^https:\/\// then https else http
    request = protocol.get @url, (res)=>
      console.log("URL: #{@url}")
      console.log("Response Code: #{res.statusCode}")
      headers = @parseHeaders(res)
      console.log headers
      res.setEncoding headers.encoding
      res.on 'data', (chunk)->
        output += chunk
      res.on 'end', ->
        if headers.contentType == 'application/xml'
          client.parseXml output, (parsedXml)->
            callback
              code: res.statusCode
              body: parsedXml
        else if headers.contentType == 'application/json'
          callback
            code: res.statusCode
            body: JSON.parse(output)
        else
          callback
            code: res.statusCode
            body: output

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
