App.SectionView = Backbone.View.extend
  initialize: ->
    @setupParallax()
    @updateBackgroundTop()
    @$more = @$('.more')

  events:
    'click .center img': 'toggleMore'

  toggleMore: ->
    if @$more.is(':visible')
      @$more.slideUp('slow')
    else
      if $('.more:visible').length > 0
        $('.more:visible').slideUp('slow')
        @showMore(delay: true)
      else
        @showMore()

  name: ->
    @el.id

  spin: ->
    window.x = 0
    @spinner = setInterval(
      =>
        window.x = window.x + 10
        console.log 'hello'
        console.log @$('.center img')
        value = "rotateY(#{window.x}deg)"
        @$('.center img').css('-webkit-transform': value)
        @$('.center img').css('color': "green")
    , 60)


  stopSpin: ->
    clearInterval(@spinner)
    @$('.center img').css('-webkit-transform': '')

  showMore: (options = {})->
    if options.delay
        setTimeout((=> @showMore()), 600)
    else
      console.log 'showing more'
      App.router.navigate @name(), trigger: false
      @$more.slideDown('slow')
      @stopSpin()

  updateBackgroundTop: ->
    $background = @$('.more img')
    offset = parseInt($background.data('offset'), 10) || 0
    newTop = ($(window).scrollTop() / 2.0) + offset + 'px'
    $background.css('top', newTop)

  setupParallax: ->
    $(window).scroll => @updateBackgroundTop()

  here: (tracks) ->
    html = "<ul>"
    for track in tracks
      html = html + "<li>" + @formatTrack(track) + "</li>"
    @$('.more ul.content ul').html(html + "</ul>")

  formatTrack: (track) ->
    track.name + ' - ' + track.artist['#text']
