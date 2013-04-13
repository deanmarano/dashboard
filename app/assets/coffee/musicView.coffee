App.MusicView = App.SectionView.extend
  template: """
    <li>
      <div class="song-title ellipsis-overflow">{{title}}</div>
      <div class="song-artist">by {{artist}}</div>
    </li>
  """

  populateView: (tracks) ->
    html = ''
    for track in tracks.slice(0, 8)
      html = html + _.template @template,
        title: track.name
        artist: track.artist['#text']
    @$('.more ul.content ul').html(html)
    @loaded = true

  getData: ->
    $.ajax
      method: 'get'
      url: '/data/lastfm'
      success: (data) =>
        @populateView(data.recenttracks.track)
        @showMore()
