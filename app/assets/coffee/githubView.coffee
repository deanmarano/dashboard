App.GithubView = App.SectionView.extend
  template: """
    <li>
      <div class="tweet-content">{{tweet}}</div>
      <div class="tweet-when">{{time}}</div>
    </li>
  """

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

  populateView: (tweets) ->
    html = ''
    for tweet in tweets
      html = html + _.template @template,
        tweet: tweet.text
        time: @formatDate(tweet.created_at)
    @$('.more .content ul').html(html)
    @loaded = true

  formatDate: (twitterDate) ->
    date = new Date(twitterDate.replace(/^\w+ (\w+) (\d+) ([\d:]+) \+0000 (\d+)$/, "$1 $2 $4 $3 UTC"))
    dateToPrint = "#{@day[date.getDay()]}, #{@month[date.getMonth()]} #{date.getDate()} at #{(date.getHours() + 11) % 12 + 1 }:#{date.getMinutes()}#{if date.getHours() < 12 then 'AM' else 'PM'}"

  getData: ->
    $.ajax
      method: 'get'
      url: '/data/github'
      success: (data) =>
        @populateView(data.slice(0,4))
        @showMore()
