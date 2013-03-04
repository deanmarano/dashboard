querystring = require 'querystring'
baseClient = require './clients/baseClient'

class Twitter
  constructor: (@settings)->

  getRecentTweetsForUser: (user, onResult)->
    query = querystring.stringify
      include_entities: true
      include_rts: true
      screen_name: user
      count: 5

    path = "#{@settings.tweetIndexPath}?#{query}"
    url = "#{@settings.host}/#{path}"

    client = new baseClient(url)
    client.get (response)=>
      onResult(response)

module.exports = (settings)-> new Twitter(settings)
