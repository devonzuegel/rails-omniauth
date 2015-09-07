(function() {
  var a, button, div, form, h1, h2, h3, h4, h5, h6, i, icon, input, p, ref, span;

  ref = React.DOM, div = ref.div, h1 = ref.h1, h2 = ref.h2, h3 = ref.h3, h4 = ref.h4, h5 = ref.h5, h6 = ref.h6, p = ref.p, a = ref.a, form = ref.form, button = ref.button, input = ref.input, icon = ref.icon, span = ref.span, i = ref.i;

  this.SearchForm = React.createClass({
    displayName: 'SearchForm',
    getInitialState: null,
    render: function() {
      return div({
        id: 'searchbar',
        role: 'search'
      }, span({
        className: 'postfix'
      }, i({
        className: 'fi-magnifying-glass'
      })), input({
        id: 'searchbar-input',
        placeholder: 'Search entries',
        onChange: this.handleChange,
        onKeyUp: this.handleEnter
      }));
    },
    handleChange: function(e) {
      return PubSub.publish('searchbar:onChange');
    },
    handleEnter: function(e) {
      var on_entries_page, pressed_enter;
      pressed_enter = e.keyCode === 13;
      on_entries_page = window.location.href.indexOf('/entries') > 0;
      if (pressed_enter && !on_entries_page) {
        return visit('/entries');
      }
    }
  });

}).call(this);
