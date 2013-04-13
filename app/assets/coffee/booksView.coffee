App.BooksView = App.SectionView.extend
  template: """
    <li>
      <div class="book-title ellipsis-overflow">{{title}}</div>
      <div class="book-author">by {{author}}</div>
    </li>
  """

  populateView: (reviews) ->
    html = ''
    for review in reviews
      html = html + _.template @template,
        title: review.book[0].title[0]
        author: review.book[0].authors[0].author[0].name[0]
    @$('.more .content ul').html(html)
    @loaded = true

  getData: ->
    $.ajax
      method: 'get'
      url: '/data/goodreads'
      success: (data) =>
        @populateView(data.shelf.GoodreadsResponse.reviews[0].review.slice(0, 8))
        @showMore()
