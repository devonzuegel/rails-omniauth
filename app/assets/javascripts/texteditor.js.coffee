class TextEditor
  constructor: (div) ->
    prevent_backspace()
    @texteditor = $(div)
    record_input($(div))

  record_input = ($texteditor) ->
    $texteditor.append document.createElement "p"
    $prev_line = null
    $current_line = $($texteditor.children()[0])

    $('body').keypress (e) ->
      if is_newline(event)
        $texteditor.append document.createElement "p"
        $current_line.addClass "pale"
        $current_line = $($texteditor.children()[$texteditor.children().length - 1])
      else
        $current_line.html( $current_line.html() + get_char_from_keycode(e) )

  get_char_from_keycode = (event) ->
    if is_newline(event) then "\n" else String.fromCharCode(event.which)

  is_newline = (event) ->
    event.keyCode is 13

  prevent_backspace = ->
    $(document).on 'keydown', (e) ->
      e.preventDefault() if e.which == 8 and !$(e.target).is('input, textarea')

  plaintext: (text) ->
    result = ""
    for child in $('#texteditor').children()
      result += $(child).html() + "\n"
    return result
    # text.replace /\<br\>/g, "\n"

$ ->
  btn = $('button#start-stop')
  texteditor = null
  btn.click (e) ->

    if btn.hasClass "start"
      btn.toggleClass "start stop"
      btn.html("Stop writing")
      btn.blur()  # Un-focus the button so it isn't pressed on "return"
      texteditor = new TextEditor $('#texteditor')
  
    else if btn.hasClass "stop"
      texteditor.plaintext()



