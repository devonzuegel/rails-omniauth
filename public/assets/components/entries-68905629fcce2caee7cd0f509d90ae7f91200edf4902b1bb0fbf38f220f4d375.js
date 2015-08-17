(function() {
  var a, button, div, form, h1, h2, h3, h4, h5, h6, icon, input, p, ref,
    indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  ref = React.DOM, div = ref.div, h1 = ref.h1, h2 = ref.h2, h3 = ref.h3, h4 = ref.h4, h5 = ref.h5, h6 = ref.h6, p = ref.p, a = ref.a, form = ref.form, button = ref.button, input = ref.input, icon = ref.icon;

  this.Entries = React.createClass({
    getInitialState: function() {
      return {
        entries: this.props.entries,
        labeled_filters: this.props.filters,
        api_key: this.props.api_key
      };
    },
    getDefaultProps: function() {
      return {
        entries: [],
        labeled_filters: [],
        api_key: ''
      };
    },
    render: function() {
      var entry, f;
      return div({
        className: 'entries'
      }, div({
        className: 'row extra-padding'
      }, (function() {
        var i, len, ref1, results1;
        ref1 = this.state.labeled_filters;
        results1 = [];
        for (i = 0, len = ref1.length; i < len; i++) {
          f = ref1[i];
          results1.push(React.createElement(Filter, {
            handleClick: this.filter,
            filter: f['filter'],
            label: f['label'],
            ref: this.filter_ref(f),
            api_key: this.state.api_key
          }));
        }
        return results1;
      }).call(this)), div({
        className: 'tiles'
      }, (function() {
        var i, len, ref1, results1;
        ref1 = this.state.entries;
        results1 = [];
        for (i = 0, len = ref1.length; i < len; i++) {
          entry = ref1[i];
          results1.push(React.createElement(Entry, {
            key: entry.id,
            entry: entry,
            handleDeletedEntries: this.deleteEntries
          }));
        }
        return results1;
      }).call(this)));
    },
    componentDidMount: function() {
      return this.setState({
        tiles: new Tiles
      });
    },
    componentDidUpdate: function() {
      var f, filter, i, len, ref1, results1;
      this.state.tiles.update();
      ref1 = this.state.labeled_filters;
      results1 = [];
      for (i = 0, len = ref1.length; i < len; i++) {
        f = ref1[i];
        filter = this.refs[this.filter_ref(f)];
        results1.push(filter.update_count());
      }
      return results1;
    },
    deleteEntries: function(entry_ids_to_remove) {
      var entries;
      entry_ids_to_remove || (entry_ids_to_remove = []);
      entries = this.state.entries.slice().filter(function(e) {
        var ref1;
        return ref1 = e.id, indexOf.call(entry_ids_to_remove, ref1) < 0;
      });
      return this.setState({
        entries: entries
      });
    },
    filter: function(entries) {
      return this.setState({
        entries: entries
      });
    },
    filter_ref: function(filter) {
      return "filter-" + filter['filter'];
    }
  });

  this.Filter = React.createClass({
    getInitialState: function() {
      this.update_count();
      return {
        api_key: this.props.api_key,
        count: '  '
      };
    },
    render: function() {
      var link_text;
      link_text = this.props.label + " (" + this.state.count + ")";
      return div({
        className: 'extra-padding pull-right'
      }, a({
        id: this.props.filter + "-filter",
        onClick: this.filter
      }, link_text));
    },
    filter: function() {
      return $.getJSON('api/v1/entries', this.data(), (function(_this) {
        return function(results) {
          return _this.props.handleClick(results);
        };
      })(this));
    },
    update_count: function() {
      return $.getJSON('api/v1/entries', this.data(), (function(_this) {
        return function(results) {
          return _this.setState({
            count: results.length
          });
        };
      })(this));
    },
    data: function() {
      var data;
      return data = {
        filter: "" + this.props.filter,
        api_key: "" + this.props.api_key
      };
    }
  });

}).call(this);
