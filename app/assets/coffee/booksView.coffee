App.BooksView = App.SectionView.extend
  populateView: (reviews) ->
    html = "<ul>"
    for review in reviews
      html = html + "<li>" + @formatReview(review) + "</li>"
    @$('.more .content').html(html + "</ul>")
    @loaded = true

  formatReview: (review) ->
    title = review.book[0].title[0]
    author = review.book[0].authors[0].author[0].name[0]
    "#{title} by #{author}"

  getData: ->
    $.ajax
      method: 'get'
      url: '/data/goodreads'
      success: (data) =>
        @populateView(data.shelf.GoodreadsResponse.reviews[0].review.slice(0, 5))
        @showMore()
