querystring = require 'querystring'
baseClient = require './clients/baseClient'

class LastFM
  constructor: (@settings)->

  getRecentTracksForUser: (user, onResult)->
    query = querystring.stringify
      method: 'user.getrecenttracks'
      user: user
      api_key: @settings.key
      format: 'json'

    path = "#{@settings.apiPath}?#{query}"
    url = "#{@settings.host}/#{path}"

    client = new baseClient(url)
    client.get (response)=>
      onResult(response)

module.exports = (settings)-> new LastFM(settings)
