baseClient = require './clients/baseClient'

class Twitter
  constructor: (@settings)->

  getRecentTweetsForUser: (user, onResult)->
    params =
      include_entities: true
      include_rts: true
      screen_name: user
      count: 5

    url = "#{@settings.host}/#{@settings.tweetIndexPath}"

    client = new baseClient(url, params)
    client.get (response)=>
      onResult(response)

module.exports = (settings)-> new Twitter(settings)
