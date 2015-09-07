{ div, h1, h2, h3, h4, h5, h6, p, a, form, button, input, icon, span, i } = React.DOM

@SearchForm = React.createClass
  displayName: 'SearchForm'

  getInitialState: null

  render: ->
    div id: 'searchbar', role: 'search',
      span className: 'postfix', i className: 'fi-magnifying-glass'
      input
        id: 'searchbar-input'
        placeholder: 'Search entries'
        onChange: @handleChange
        onKeyUp: @handleEnter

  handleChange: (e) ->
    PubSub.publish 'searchbar:onChange'

  handleEnter: (e) ->
    pressed_enter   = (e.keyCode == 13)
    on_entries_page = (window.location.href.indexOf('/entries') > 0)
    visit('/entries') if pressed_enter && !on_entries_page
