{ div, h1, h2, h3, h4, h5, h6, p, a, form, button, input, icon } = React.DOM

@Entry = React.createClass
  render: ->
    div className: 'col-md-6 no-padding',
      div className: 'entry-card', id: "entry-#{@props.entry.id}",
        div className: 'fade'

        div className: 'absolute right-top',
          a
            className: 'fi-x',
            onClick: @deleteEntry

        h2 null, @props.entry.title
        div className: 'date', formatted_date(@props.entry.created_at)
        p null, formatted_body(@props.entry)

  
  deleteEntry: (e) ->
    e.preventDefault()
    confirmed = confirm 'Are you sure you want to delete this entry?'
    if confirmed
      id = @props.entry.id
      $.ajax
        method: 'DELETE'
        url: "/entries/#{id}.json"
        dataType: 'JSON'
        success: () =>
          @props.handleDeletedEntries [id]
