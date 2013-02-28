window.App =
  getSection: (id)->
    for section in App.sections
      return section if section.name() == id

  setup: ->
    App.router = new App.Router()
    @sections = $('.section').map (index, el)->
      new App.SectionView
        el: el
    Backbone.history.start(pushState: false)
