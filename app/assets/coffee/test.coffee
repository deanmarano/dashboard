#= require ../../../public/lib/jquery.min
#= require ../../../public/lib/underscore
#= require ../../../public/lib/backbone

SectionView = Backbone.View.extend
  initialize: ->
    console.log @$el
  events:
    'click .center img': 'toggleMore'

  toggleMore: ->
    @$('.more').slideToggle('slow')


$ ->
  $('.section').each (index, el)->
    new SectionView
      el: el
  $window = $(window)
  $window.scroll ->
    newTop = ($window.scrollTop() / 2.5) + 200 + 'px'
    $('.more img').css('top', newTop)
