#= require ../../../public/lib/jquery.min
#= require ../../../public/lib/underscore
#= require ../../../public/lib/backbone

SectionView = Backbone.View.extend
  initialize: ->
    @setupParallax()
    @updateBackgroundTop()

  events:
    'click .center img': 'toggleMore'

  toggleMore: ->
    $more = @$('.more')
    if $more.is(':visible')
      @$('.more').slideUp('slow')
    else
      if $('.more:visible').length > 0
        $('.more:visible').slideUp('slow')
        setTimeout((=> $more.slideDown('slow')), 600)
      else
        $more.slideDown('slow')


  updateBackgroundTop: ->
    $background = @$('.more img')
    offset = parseInt($background.data('offset'), 10) || 0
    newTop = ($(window).scrollTop() / 2.0) + offset + 'px'
    $background.css('top', newTop)

  setupParallax: ->
    $(window).scroll => @updateBackgroundTop()


$ ->
  $('.section').each (index, el)->
    console.log el
    new SectionView
      el: el
