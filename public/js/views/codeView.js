(function() {

  App.Views.CodeView = Backbone.View.extend({
    toggle: function() {
      debugger;      if (this.$el.is(':visible')) {
        return this.$el.sideUp('slow');
      } else {
        return this.$el.slideDown('slow');
      }
    }
  });

}).call(this);
