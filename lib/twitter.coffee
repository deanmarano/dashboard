baseClient = require './clients/baseClient'

class Twitter
  constructor: (@settings) ->

  formatTweets: (responseBody) ->
    responseBody

  formatTweet: (tweet) ->
    tweetHTML = tweet.text
    for mention in tweet.entities.user_mentions
      tweetHTML = tweetHTML.replace(new RegExp("@#{mention.screen_name}"), "<a href='http://twitter.com/#{mention.screen_name}'>@#{mention.screen_name}</a>")
    for url in tweet.entities.urls
      tweetHTML = tweetHTML.replace(url.url, "<a href='#{url.expanded_url}'>#{url.expanded_url}</a>")
    tweetHTML


  getRecentTweetsForUser: (user, onResult) ->
    params =
      include_entities: true
      include_rts: true
      screen_name: user
      count: 5

    url = "#{@settings.host}/#{@settings.tweetIndexPath}"

    client = new baseClient(url, params)
    client.get (response)=>
      if response.code == 200
        response.body = @formatTweets(response.body)
      onResult(response)

module.exports = (settings)-> new Twitter(settings)
