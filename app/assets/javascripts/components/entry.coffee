{ div, h1, h2, h3, h4, h5, h6, p, a, form, button, input, icon } = React.DOM

@Entry = React.createClass
  render: ->
    div className: 'tile',
      if gon.current_visitor.id == @props.entry.visitor_id
        a className: 'absolute right-top fi-x subtle-link', onClick: @deleteEntry
      a href: "/entries/#{@props.entry.id}",
        div className: 'entry-card', id: "entry-#{@props.entry.id}",

          h2 null, @props.entry.title
          div className: 'date', "Updated #{time_ago(@props.entry.updated_at)}"
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
        success: (result) =>
          @props.handleDeletedEntries [id]