window.App =
  getSection: (id)->
    for section in App.sections
      return section if section.name() == id

  setup: ->
    @sections = $('.section').map (index, el)->
      if el.id == 'music'
        new App.MusicView
          el: el
      else if el.id == 'books'
        new App.BooksView
          el: el
      else if el.id == 'twitter'
        new App.TwitterView
          el: el
      else
        new App.SectionView
          el: el

    App.router = new App.Router()
    Backbone.history.start(pushState: false)
