(function() {

  window.App = {};

  App.Router = Backbone.Router.extend({
    routes: {
      "(/)": "index",
      "help": "help",
      "search/:query": "search",
      "search/:query/p:page": "search"
    },
    index: function() {
      return $('a img').parent().click(function(e) {
        e.preventDefault();
        return App.router.navigate($(e.currentTarget).attr('href'));
      });
    },
    help: function() {},
    search: function(query, page) {}
  });

  $(function() {
    App.router = new App.Router;
    return Backbone.history.start({
      pushState: true
    });
  });

}).call(this);
