@formatted_date = (date) ->
  d = new Date(date)
  moment(d).format('MMMM Do, YYYY')

@word_count = (entry) ->
  (entry.body is not null) && entry.body.split.size || 0

@formatted_body = (entry) ->
  entry.body.replace("\n", "\n\n") unless entry.body is null