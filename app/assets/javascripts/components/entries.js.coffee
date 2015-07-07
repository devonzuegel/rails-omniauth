@Entries = React.createClass
  getInitialState: ->
    entries: @props.data

  getDefaultProps: ->
    entries: []

  render: ->
    React.DOM.div
      className: 'entries'

      for entry in @state.entries
        React.createElement Entry, key: entry.id, entry: entry