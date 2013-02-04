(function() {

  window.App = {
    Views: {}
  };

  App.Router = Backbone.Router.extend({
    routes: {
      "(/)": "index",
      "code(/)": "code",
      "books(/)": "books"
    },
    index: function() {
      return this.initialize();
    },
    code: function() {
      this.initialize();
      this.codeView || (this.codeView = new App.Views.CodeView({
        el: $('.code.more')
      }));
      return this.codeView.toggle();
    },
    books: function() {
      this.initialize();
      return $(".books.more").slideDown('slow');
    },
    initialize: function() {
      if (this.initialized != null) {
        return;
      }
      $('a img').parent().click(function(e) {
        e.preventDefault();
        return App.router.navigate($(e.currentTarget).attr('href'));
      });
      return this.initialized = true;
    }
  });

  $(function() {
    App.router = new App.Router;
    return Backbone.history.start({
      pushState: true
    });
  });

}).call(this);
