class TextEditor
  constructor: (@$texteditor) ->
    $current_line = $('#current-line')

    prevent_backspace()

    $('body').keypress (e) ->
      $current_line.append(get_char_from_keycode(e))

    $('#sofar').click (e) ->
      alert plaintext($current_line.html())

  get_char_from_keycode = (event) ->
    if is_newline(event) then "<br>" else String.fromCharCode(event.which)

  is_newline = (event) ->
    event.keyCode is 13

  prevent_backspace = ->
    $(document).on 'keydown', (e) ->
      e.preventDefault() if e.which == 8 and !$(e.target).is('input, textarea')

  plaintext = (text) ->
    text.replace /\<br\>/g, "\n"

$ ->
  texteditor = new TextEditor $('.texteditor')