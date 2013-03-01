window.App =
  getSection: (id)->
    for section in App.sections
      return section if section.name() == id

  setup: ->
    @sections = $('.section').map (index, el)->
      new App.SectionView
        el: el

    App.router = new App.Router()
    Backbone.history.start(pushState: false)
