{ div, h1, h2, h3, h4, h5, h6, p, a, form, button, input, icon } = React.DOM

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

  # Current component sends data back to the parent component 
  # through @props.handleNewEntry to notify it about the 
  # existence of a new entry. Wherever we create our EntryForm
  # element, we need to pass a handleNewEntry property with a
  # method reference into it.
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/entries', { entry: @state }, (results) =>
      @props.handleNewEntry results
      @setState @getInitialState()
    , 'JSON'

  valid: ->
    @state.title

  # @setState performs 2 actions:
  # (1) Updates the component's state
  # (2) Schedules a UI verification/refresh based on the new state
  handleChange: (e) ->
    name  = e.target.name
    value = e.target.value
    @setState "#{name}": value
