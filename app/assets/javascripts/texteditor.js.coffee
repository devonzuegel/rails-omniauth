class TextEditor
  constructor: (div) ->
    prevent_backspace()
    record_input($(div))

  record_input = ($texteditor) ->
    $texteditor.append document.createElement "p"
    $prev_line = null
    $current_line = $($texteditor.children()[0])
    $('body').keypress (e) ->
      char = get_char_from_keycode(e)
      if char is "<br>"
        $texteditor.append document.createElement "p"
        $current_line.addClass "pale"
        $current_line = $($texteditor.children()[$texteditor.children().length - 1])
      else
        new_text = $current_line.html() + char
        $current_line.html(new_text)

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
  texteditor = new TextEditor $('#texteditor')