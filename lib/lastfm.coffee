baseClient = require './clients/baseClient'

class LastFM
  constructor: (@settings)->

  getRecentTracksForUser: (user, onResult)->
    url = "#{@settings.host}/#{@settings.apiPath}"

    params =
      method: 'user.getrecenttracks'
      user: user
      api_key: @settings.key
      format: 'json'

    client = new baseClient(url, params)
    client.get (response)=>
      onResult(response)

module.exports = (settings)-> new LastFM(settings)
