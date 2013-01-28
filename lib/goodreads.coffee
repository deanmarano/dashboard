querystring = require 'querystring'
baseClient = require './clients/baseClient'

class GoodreadsUser
  constructor: (userXml, whenLoaded)->
    @xml = userXml
    @load(whenLoaded)

  id: ->
    @userData.id[0]

  load: (onResult)->
    @userData = @xml.GoodreadsResponse.user[0]
    onResult(@)

  addShelves: (data)->
    @shelfData = data

  addShelf: (shelf)->
    @shelf = shelf

  shelves: ->
    @shelfData.GoodreadsResponse.reviews[0]

  book: (index) ->
    review = @shelfData.GoodreadsResponse.reviews[0].review[index]
    book = review.book[0]
    {
      title: book.title[0]
      shelf: review.shelves[0].shelf[0].$.name
      dateAdded: review.date_added[0]
      author: book.authors[0].author[0].name[0]
    }

class Goodreads
  constructor: (@settings)->

  getUser: (userId, onResult)->
    query = querystring.stringify
      key: @settings.key
      id: userId

    path = "#{@settings.userShowPath.replace(':id', userId)}?#{query}"
    url = "#{@settings.host}/#{path}"

    client = new baseClient(url)
    client.get (response)=>
      new GoodreadsUser response.body, (user)->
        onResult(user)

  getShelvesForUser: (user, onResult)->
    query = querystring.stringify
      key: @settings.key
      v: 2

    path = "#{@settings.reviewListPath.replace(':id', user.id())}?#{query}"
    url = "#{@settings.host}/#{path}"

    client = new baseClient(url)
    client.get (response)=>
      user.addShelves(response.body)
      onResult(user)

  getShelfForUser: (user, shelfName, onResult)->
    query = querystring.stringify
      key: @settings.key
      v: 2
      shelf: shelfName
      sort: 'date_added'
      order: 'd'

    path = "#{@settings.reviewListPath.replace(':id', user.id())}?#{query}"
    url = "#{@settings.host}/#{path}"

    client = new baseClient(url)
    client.get (response)=>
      user.addShelf(response.body)
      onResult(user)

module.exports = (settings)-> new Goodreads(settings)
