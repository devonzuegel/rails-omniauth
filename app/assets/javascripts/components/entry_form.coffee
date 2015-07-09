{ div, h1, h2, h3, h4, h5, h6, p, a, form, button, input } = React.DOM

@EntryForm = React.createClass

  getInitialState: ->
    title: ''
    date: ''
    amount: ''

  render: ->
    form className: 'form-inline', onSubmit: @handleSubmit,
      div className: 'form-group',
        input 
          className: 'form-control',
          type: 'text'
          placeholder: 'Title'
          name: 'title'
          value: @state.title
          onChange: @handleChange
      button
        className: 'btn btn-primary',
        type: 'submit'
        disabled: !@valid()
        'Create entry'

  handleSubmit: (e) ->
    # Current component sends data back to the parent component 
    # through @props.handleNewEntry to notify it about the 
    # existence of a new entry. Wherever we create our 
    # EntryForm element, we need to pass a handleNewEntry
    # property with a method reference into it.
    current_url = ''
    e.preventDefault()
    $.post current_url, { entry: @state }, (data) =>
      @props.handleNewEntry data
      @setState @getInitialState()
    , 'JSON'

  valid: ->
    # TODO change me!
    true
    # @state.title && @state.date && @state.amount

  handleChange: (e) ->
    name  = e.target.name
    value = e.target.value
    # @setState performs 2 actions:
    # (1) Updates the component's state
    # (2) Schedules a UI verification/refresh based on the new state
    @setState "#{ name }": value
