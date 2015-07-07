{ div, h1, h2, h3, h4, h5, h6, p, a } = React.DOM

@Entry = React.createClass
  render: ->
    div className: 'col-md-6 no-padding',
      div className: 'entry-card',
        div className: 'fade'

        # icon className: 'absolute right-top'
        #   - if entry.user == current_user && signed_in?
        #     = link_to entry, data: { confirm: 'Are you sure?' },
        #                      method: :delete, class: "link-btn"
        #       i.fi-trash

        h2 null, @props.entry.title
        div className: 'date', formatted_date(@props.entry.created_at)
        p null, formatted_body(@props.entry)