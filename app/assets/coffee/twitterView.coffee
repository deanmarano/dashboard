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
      html = html + _.template @template, tweet
    @$('.more .content ul').html(html)
    @loaded = true

  getData: ->
    $.ajax
      method: 'get'
      url: '/data/twitter'
      success: (data) =>
        @populateView(data)
        @showMore()
