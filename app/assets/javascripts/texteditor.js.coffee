class TextEditor
  constructor: (div) ->
    prevent_backspace()
    @texteditor = $(div)
    record_input($(div))

  record_input = ($texteditor) ->
    @wordcount = 0
    $texteditor.append document.createElement "p"
    $prev_line = null
    $current_line = $($texteditor.children()[0])
    $current_line.text ""

    $(document).keypress (e) ->
      scroll_to_bottom()
      if is_space(event) then increment_wordcount()

      if is_newline(event)
        $texteditor.append document.createElement "p"
        $current_line.addClass "pale"
        $current_line = $($texteditor.children()[$texteditor.children().length - 1])
        $current_line.text
      else
        $current_line.html( $current_line.html() + get_char_from_keycode(e) )

  scroll_to_bottom = ->
    $('html, body').animate { scrollTop: $(document).height() }, 'fast'

  get_char_from_keycode = (event) ->
    if is_newline(event) then "\n" else String.fromCharCode(event.which)

  is_newline = (event) ->
    event.keyCode is 13

  is_space = (event) ->   # True on newlines, spaces, and tabs.
    is_newline(event) or (event.keyCode is 32) or (event.keyCode is 9)

  increment_wordcount = ->
    @wordcount++
    $('#wordcount').text "#{wordcount} words"

  prevent_backspace = ->
    $(document).on 'keydown', (e) ->
      e.preventDefault() if e.which == 8 and !$(e.target).is('input, textarea')

  plaintext: () ->
    result = ""
    for child in $('#texteditor').children()
      result += $(child).html() + "\n"
    return result


$ ->
  if gon.controller is "entries" and gon.action is "edit"
    btn = $('input#start-stop')
    texteditor = new TextEditor $('#texteditor')
    btn.click (e) ->
      if btn.hasClass "stop"
        $('#entry_body').val texteditor.plaintext()
