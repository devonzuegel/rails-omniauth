(function() {
  var a, button, div, form, h1, h2, h3, h4, h5, h6, icon, input, p, ref,
    indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  ref = React.DOM, div = ref.div, h1 = ref.h1, h2 = ref.h2, h3 = ref.h3, h4 = ref.h4, h5 = ref.h5, h6 = ref.h6, p = ref.p, a = ref.a, form = ref.form, button = ref.button, input = ref.input, icon = ref.icon;

  this.Entries = React.createClass({
    getInitialState: function() {
      return {
        entries: JSON.parse(this.props.entries)
      };
    },
    getDefaultProps: function() {
      return {
        entries: []
      };
    },
    render: function() {
      var entry;
      return div({
        className: 'entries'
      }, div({
        className: 'row extra-padding'
      }, React.createElement(Filter, {
        handleClick: this.filter,
        filter: 'all',
        label: 'All'
      }), React.createElement(Filter, {
        handleClick: this.filter,
        filter: 'just_mine',
        label: 'Mine'
      }), React.createElement(Filter, {
        handleClick: this.filter,
        filter: 'others',
        label: 'Others'
      })), div({
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
      this.setState({
        tiles: new Tiles
      });
      return console.log('componentDidMount');
    },
    componentDidUpdate: function() {
      this.state.tiles.update();
      return console.log('componentDidUpdate');
    },
    addEntry: function(entry) {
      var entries;
      entries = this.state.entries.slice();
      entries.push(entry);
      return this.setState({
        entries: entries
      });
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
    }
  });

  this.Filter = React.createClass({
    getInitialState: function() {
      this.count();
      return {
        count: '-'
      };
    },
    render: function() {
      return div({
        className: 'col-xs-2 pull-right'
      }, a({
        onClick: this.filter
      }, this.props.label + " (" + this.state.count + ")"));
    },
    filter: function() {
      return $.getJSON('/entries', {
        filter: this.props.filter
      }, (function(_this) {
        return function(results) {
          return _this.props.handleClick(results);
        };
      })(this));
    },
    count: function() {
      return $.getJSON('/entries', {
        filter: this.props.filter
      }, (function(_this) {
        return function(results) {
          return _this.setState({
            count: results.length
          });
        };
      })(this));
    }
  });

}).call(this);
