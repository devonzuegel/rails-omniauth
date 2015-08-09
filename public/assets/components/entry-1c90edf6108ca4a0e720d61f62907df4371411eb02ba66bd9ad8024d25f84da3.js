(function() {
  var a, button, div, form, h1, h2, h3, h4, h5, h6, icon, input, p, ref;

  ref = React.DOM, div = ref.div, h1 = ref.h1, h2 = ref.h2, h3 = ref.h3, h4 = ref.h4, h5 = ref.h5, h6 = ref.h6, p = ref.p, a = ref.a, form = ref.form, button = ref.button, input = ref.input, icon = ref.icon;

  this.Entry = React.createClass({
    render: function() {
      return div({
        className: 'tile',
        id: "entry-" + this.props.entry.id
      }, div({
        className: 'entry-card'
      }, div({
        className: 'fade'
      }), gon.current_visitor.id === this.props.entry.visitor_id ? div({
        className: 'absolute right-top'
      }, a({
        className: 'fi-x',
        onClick: this.deleteEntry
      })) : void 0, h2(null, this.props.entry.title), div({
        className: 'date'
      }, "Updated " + (time_ago(this.props.entry.updated_at))), p(null, formatted_body(this.props.entry))));
    },
    deleteEntry: function(e) {
      var confirmed, id;
      e.preventDefault();
      confirmed = confirm('Are you sure you want to delete this entry?');
      if (confirmed) {
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
