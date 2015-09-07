{ div, h1, h2, h3, h4, h5, h6, p, a, form, button, input, icon } = React.DOM

@Entries = React.createClass
  displayName: 'Entries'

  getInitialState: ->
    current_filter:  'default'
    entries:         @props.entries
    labeled_filters: @props.filters
    api_key:         @props.api_key

  getDefaultProps: ->
    entries:         []
    labeled_filters: []
    api_key:         ''

  render: ->
    div className: 'entries',
      div className: 'row extra-padding',
        for f in @state.labeled_filters
          React.createElement Filter,
            handleClick:  @filter
            filter_name:  f['filter']
            label:        f['label']
            ref:          @filter_ref(f)
            api_key:      @state.api_key
      div className: 'tiles',
        for entry in @state.entries
          React.createElement Entry,
            key:                   entry.id
            entry:                 entry
            handleDeletedEntries:  @deleteEntries

  componentDidMount: ->
    DELAY_MS = 0
    lazy_search_filter = _.debounce @search_filter, DELAY_MS
    PubSub.subscribe 'searchbar:onChange', () => lazy_search_filter()
    @setState tiles: new Tiles

  componentDidUpdate: ->
    @state.tiles.update()
    for f in @state.labeled_filters
      filter = @refs[@filter_ref(f)]
      filter.update_count()

  deleteEntries: (entry_ids_to_remove) ->
    entry_ids_to_remove ||= []
    entries = @state.entries.slice().filter (e) ->
      e.id not in entry_ids_to_remove
    @setState entries: entries

  filter: (entries, filter_name) ->
    @setState entries: entries, current_filter: filter_name

  filter_ref: (filter) ->
    "filter-#{filter['filter']}"

  search_filter: ->
    data = {
      api_key: "#{@state.api_key}",
      query:   "#{$('#searchbar-input').val()}",
      filter:  @props.current_filter
    }
    $.getJSON 'api/v1/entries', data, (results) =>
      @filter(results)

@Filter = React.createClass
  getInitialState: ->
    @update_count()
    api_key: @props.api_key
    count:   '  '  # count is blank until it's computed

  render: ->
    link_text = "#{@props.label} (#{@state.count})"
    div className: 'extra-padding pull-right',
      a id: "#{@props.filter_name}-filter", onClick: @filter, link_text

  filter: ->
    $.getJSON 'api/v1/entries', @data(), (results) =>
      @props.handleClick results, @props.filter_name

  update_count: ->
    $.getJSON 'api/v1/entries', @data(), (results) =>
      @setState count: results.length

  data: ->
    data = {
      filter:  "#{@props.filter_name}",
      api_key: "#{@props.api_key}",
      query:   "#{$('#searchbar-input').val()}"
    }