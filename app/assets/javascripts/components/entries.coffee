{ div, h1, h2, h3, h4, h5, h6, p, a, form, button, input } = React.DOM

@Entries = React.createClass
  
  getInitialState: ->
    entries: @props.data

  getDefaultProps: ->
    entries: []

  render: ->
    React.DOM.div className: 'entries',

      React.createElement EntryForm, handleNewEntry: @addEntry

      for entry in @state.entries
        React.createElement Entry, key: entry.id, entry: entry

  addEntry: (entry) ->
    entries = @state.entries.slice()
    entries.push entry
    @setState entries: entries