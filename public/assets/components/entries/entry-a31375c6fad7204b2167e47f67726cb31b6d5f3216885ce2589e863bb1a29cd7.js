(function() {
  var a, button, div, form, h1, h2, h3, h4, h5, h6, icon, input, p, ref;

  ref = React.DOM, div = ref.div, h1 = ref.h1, h2 = ref.h2, h3 = ref.h3, h4 = ref.h4, h5 = ref.h5, h6 = ref.h6, p = ref.p, a = ref.a, form = ref.form, button = ref.button, input = ref.input, icon = ref.icon;

  this.Entry = React.createClass({
    render: function() {
      return div({
        className: 'tile'
      }, gon.current_visitor.id === this.props.entry.visitor_id ? a({
        id: "delete-entry-" + this.props.entry.id,
        className: 'absolute right-top subtle-link fi-x',
        onClick: this.deleteEntry
      }) : void 0, a({
        href: "/entries/" + this.props.entry.id
      }, div({
        className: 'entry-card',
        id: "entry-" + this.props.entry.id
      }, h2(null, this.props.entry.title), div({
        className: 'date'
      }, "Updated " + (time_ago(this.props.entry.updated_at))), p(null, formatted_body(this.props.entry)))));
    },
    deleteEntry: function(e) {
      var id;
      e.preventDefault();
      if (confirm('Are you sure you want to delete this entry?')) {
        id = this.props.entry.id;
        return $.ajax({
          method: 'DELETE',
          url: "/entries/" + id + ".json",
          dataType: 'JSON',
          success: (function(_this) {
            return function(result) {
              return _this.props.handleDeletedEntries([id]);
            };
          })(this)
        });
      }
    }
  });

}).call(this);
