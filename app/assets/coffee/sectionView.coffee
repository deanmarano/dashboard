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

  showMore: (options = {})->
    if options.delay
        setTimeout((=> @showMore()), 600)
    else
      console.log 'showing more'
      App.router.navigate @name(), trigger: false
      @$more.slideDown('slow')

  updateBackgroundTop: ->
    $background = @$('.more img')
    offset = parseInt($background.data('offset'), 10) || 0
    newTop = ($(window).scrollTop() / 2.0) + offset + 'px'
    $background.css('top', newTop)

  setupParallax: ->
    $(window).scroll => @updateBackgroundTop()
