{ div, h1, h2, h3, h4, h5, h6, p, a, form, button, input, icon } = React.DOM


@Entries = React.createClass
  
  getInitialState: ->
    # console.log JSON.stringify(JSON.parse(@props.entries), null, 3)
    entries: JSON.parse(@props.entries)

  getDefaultProps: ->
    entries: []

  render: ->
    React.DOM.div className: 'entries',
      React.createElement Filter, handleClick: @filterEntries
      div className: 'row',
        React.createElement Stats, type: 'success', count: @entry_count(), text: 'Count'
      React.createElement EntryForm, handleNewEntry: @addEntry
      for entry in @state.entries
        React.createElement Entry,
          key: entry.id
          entry: entry
          handleDeletedEntries: @deleteEntries

  addEntry: (entry) ->
    entries = @state.entries.slice()
    entries.push entry
    @setState entries: entries

  deleteEntries: (entry_ids_to_remove) ->
    entry_ids_to_remove ||= []
    entries = @state.entries.filter (e) -> e.id not in entry_ids_to_remove
    @setState entries: entries

  entry_count: ->
    @state.entries.length

  filterEntries: (entries) ->
    console.log JSON.stringify(entries, null, 3)
    @setState entries: entries


@Filter = React.createClass
  render: ->
    div className: 'row extra-padding',
      div className: 'col-xs-2 pull-right',
        a
          onClick: @filterEntries
          'Just mine'

  filterEntries: ->
    filter = 'just_mine'
    alert filter
    $.getJSON '/entries', { filter: filter }, (results) =>
      @props.handleClick results


@Stats = React.createClass

  render: ->
    div className: 'col-md-3',
      div className: "panel panel-#{@props.type}",
        div className: 'panel-heading', @props.text
        div className: 'panel-body', @props.count

