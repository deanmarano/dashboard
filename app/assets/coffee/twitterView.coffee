App.TwitterView = App.SectionView.extend
  populateView: (tweets) ->
    html = "<ul>"
    for tweet in tweets
      html = html + "<li>" + @formatTweet(tweet) + "</li>"
    @$('.more .content').html(html + "</ul>")

  formatTweet: (tweet) ->
    tweet.text + ' at ' + tweet.created_at

  expand: ->
    @spin()
    @getData()

  getData: ->
    $.ajax
      method: 'get'
      url: '/data/twitter'
      success: (data) =>
        @populateView(data)
        @showMore()
