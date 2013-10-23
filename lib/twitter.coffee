baseClient = require './clients/baseClient'

class Twitter
  constructor: (@settings) ->

  formatTweets: (responseBody) ->
    responseBody.map (tweet) =>
      tweet: @formatTweet(tweet)
      time: @formatDate(tweet.created_at)

  formatTweet: (tweet) ->
    tweetHTML = tweet.text
    for mention in tweet.entities.user_mentions
      tweetHTML = tweetHTML.replace(new RegExp("@#{mention.screen_name}"), "<a href='http://twitter.com/#{mention.screen_name}'>@#{mention.screen_name}</a>")
    for url in tweet.entities.urls
      tweetHTML = tweetHTML.replace(url.url, "<a href='#{url.expanded_url}'>#{url.expanded_url}</a>")
    tweetHTML

  formatDate: (twitterDate) ->
    date = new Date(twitterDate.replace(/^\w+ (\w+) (\d+) ([\d:]+) \+0000 (\d+)$/, "$1 $2 $4 $3 UTC"))
    ampm = if date.getHours() < 12 then 'AM' else 'PM'
    dateToPrint = "#{@day[date.getDay()]}, #{@month[date.getMonth()]} #{date.getDate()} at #{(date.getHours() + 11) % 12 + 1 }:#{date.getMinutes()} #{ampm}"

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

  day: [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ]

  month: [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ]

module.exports = (settings)-> new Twitter(settings)
