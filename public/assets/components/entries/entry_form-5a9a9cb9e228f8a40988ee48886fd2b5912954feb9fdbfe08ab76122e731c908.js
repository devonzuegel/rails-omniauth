(function() {
  var a, button, div, form, h1, h2, h3, h4, h5, h6, icon, input, p, ref;

  ref = React.DOM, div = ref.div, h1 = ref.h1, h2 = ref.h2, h3 = ref.h3, h4 = ref.h4, h5 = ref.h5, h6 = ref.h6, p = ref.p, a = ref.a, form = ref.form, button = ref.button, input = ref.input, icon = ref.icon;

  this.EntryForm = React.createClass({
    getInitialState: function() {
      return {
        title: '',
        date: '',
        amount: ''
      };
    },
    render: function() {
      return form({
        className: 'form-inline',
        onSubmit: this.handleSubmit
      }, div({
        className: 'form-group'
      }, input({
        className: 'form-control',
        type: 'text',
        placeholder: 'Title',
        name: 'title',
        value: this.state.title,
        onChange: this.handleChange
      })), button({
        className: 'btn btn-primary',
        type: 'submit',
        disabled: !this.valid()
      }, 'Create entry'));
    },
    handleSubmit: function(e) {
      e.preventDefault();
      return $.post('/entries', {
        entry: this.state
      }, (function(_this) {
        return function(results) {
          _this.props.handleNewEntry(results);
          return _this.setState(_this.getInitialState());
        };
      })(this), 'JSON');
    },
    valid: function() {
      return this.state.title;
    },
    handleChange: function(e) {
      var name, obj, value;
      name = e.target.name;
      value = e.target.value;
      return this.setState((
        obj = {},
        obj["" + name] = value,
        obj
      ));
    }
  });

}).call(this);
