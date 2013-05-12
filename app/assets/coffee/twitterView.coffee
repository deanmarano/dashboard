App.TwitterView = App.SectionView.extend
  template: """
    <li>
      <div class="tweet-content">{{tweet}}</div>
      <div class="tweet-when">{{time}}</div>
    </li>
  """

  populateView: (tweets) ->
    html = ''
    for tweet in tweets
      tweetHTML = @formatTweet(tweet)
      html = html + _.template @template,
        tweet: tweetHTML
        time: @formatDate(tweet.created_at)
    @$('.more .content ul').html(html)
    @loaded = true

  formatDate: (twitterDate) ->
    date = new Date(twitterDate.replace(/^\w+ (\w+) (\d+) ([\d:]+) \+0000 (\d+)$/, "$1 $2 $4 $3 UTC"))
    dateToPrint = "#{@day[date.getDay()]}, #{@month[date.getMonth()]} #{date.getDate()} at #{(date.getHours() + 11) % 12 + 1 }:#{date.getMinutes()}#{if date.getHours() < 12 then 'AM' else 'PM'}"

  formatTweet: (tweet) ->
    tweetHTML = tweet.text
    for mention in tweet.entities.user_mentions
      tweetHTML = tweetHTML.replace(new RegExp("@#{mention.screen_name}"), "<a href='http://twitter.com/#{mention.screen_name}'>@#{mention.screen_name}</a>")
    for url in tweet.entities.urls
      tweetHTML = tweetHTML.replace(url.url, "<a href='#{url.expanded_url}'>#{url.expanded_url}</a>")
    tweetHTML

  getData: ->
    $.ajax
      method: 'get'
      url: '/data/twitter'
      success: (data) =>
        @populateView(data.slice(0,4))
        @showMore()

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

