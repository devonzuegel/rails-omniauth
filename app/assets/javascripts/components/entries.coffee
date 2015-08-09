{ div, h1, h2, h3, h4, h5, h6, p, a, form, button, input, icon } = React.DOM

@Entries = React.createClass

  getInitialState: ->
    entries: JSON.parse(@props.entries)

  getDefaultProps: ->
    entries: []


  render: ->
    div className: 'entries',
      div className: 'row extra-padding',
        React.createElement Filter, handleClick: @filter, filter: 'all', label: 'All'
        React.createElement Filter, handleClick: @filter, filter: 'just_mine', label: 'Mine'
        React.createElement Filter, handleClick: @filter, filter: 'others', label: 'Others'
      div className: 'tiles',
        for entry in @state.entries
          React.createElement Entry,
            key: entry.id
            entry: entry
            handleDeletedEntries: @deleteEntries

  componentDidMount: ->
    @setState tiles: new Tiles

  componentDidUpdate: ->
    @state.tiles.update()

  addEntry: (entry) ->
    entries = @state.entries.slice()
    entries.push entry
    @setState entries: entries

  deleteEntries: (entry_ids_to_remove) ->
    entry_ids_to_remove ||= []
    entries = @state.entries.slice().filter (e) ->
      e.id not in entry_ids_to_remove
    @setState entries: entries

  filter: (entries) ->
    @setState entries: entries


@Filter = React.createClass
  getInitialState: ->
    @count()
    count: '-'

  render: ->
    div className: 'col-xs-2 pull-right', a
      onClick: @filter
      "#{@props.label} (#{@state.count})"

  filter: ->
    $.getJSON '/entries', { filter: @props.filter }, (results) =>
      @props.handleClick results

  count: ->
    $.getJSON '/entries', { filter: @props.filter }, (results) =>
      @setState count: results.length