window.App =
  sectionMappings: ->
    music: App.MusicView
    books: App.BooksView
    twitter: App.TwitterView
    code: App.GithubView

  getSection: (id)->
    for section in App.sections
      return section if section.name() == id

  setup: ->
    @sections = $('.section').map (index, el)=>
      section = @sectionMappings()[el.id]
      if section?
        new section
          el: el
      else
        new App.SectionView
          el: el

    _.templateSettings =
      interpolate : /\{\{(.+?)\}\}/g

    App.router = new App.Router()
    Backbone.history.start(pushState: false)
