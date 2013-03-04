App.MusicView = App.SectionView.extend
  populateView: (tracks) ->
    html = "<ul>"
    for track in tracks
      html = html + "<li>" + @formatTrack(track) + "</li>"
    @$('.more ul.content ul').html(html + "</ul>")
    @loaded = true

  formatTrack: (track) ->
    track.name + ' - ' + track.artist['#text']

  getData: ->
    $.ajax
      method: 'get'
      url: '/data/lastfm'
      success: (data) =>
        @populateView(data.body.recenttracks.track)
        @showMore()
