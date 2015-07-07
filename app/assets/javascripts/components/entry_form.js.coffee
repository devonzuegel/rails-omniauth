@EntryForm = React.createClass

  getInitialState: ->
    title: ''
    date: ''
    amount: ''

  render: ->
    React.DOM.form className: 'form-inline',
      React.DOM.div className: 'form-group',
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Date'
          name: 'date'
          value: @state.date
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Title'
          name: 'title'
          value: @state.title
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'number'
          className: 'form-control'
          placeholder: 'Amount'
          name: 'amount'
          value: @state.amount
          onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create entry'

  handleSubmit: (e) ->
    # Current component sends data back to the parent component 
    # through @props.handleNewRecord to notify it about the 
    # existence of a new record. Wherever we create our 
    # RecordForm element, we need to pass a handleNewRecord 
    # property with a method reference into it.
    current_url = ''
    e.preventDefault()
    $.post current_url, { entry: @state }, (data) =>
      @props.handleNewRecord data
      @setState @getInitialState()
    , 'JSON'

  valid: ->
    @state.title && @state.date && @state.amount

  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
