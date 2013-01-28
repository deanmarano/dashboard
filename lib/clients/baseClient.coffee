http = require 'http'
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
    request = http.get @url, (res)=>
      console.log("URL: #{@url}")
      console.log("Response Code: #{res.statusCode}")
      headers = @parseHeaders(res)
      console.log headers
      res.setEncoding headers.encoding
      res.on 'data', (chunk)->
        output += chunk
      res.on 'end', ->
        #console.log("Response Body: #{output}")
        if headers.contentType == 'application/xml'
          client.parseXml output, (parsedXml)->
            callback
              code: res.statusCode
              body: parsedXml
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
