class TextEditor

  constructor: (selector) ->
    prevent_backspace()
    record_input ( @$texteditor = $(selector) )

  plaintext: ->
    @$texteditor.text()


  ##### HELPERS #####

  record_input = ($texteditor) ->
    $texteditor.append document.createElement 'p'
    $prev_line = null
    $current_line = $($texteditor.children()[0])
    $current_line.text ''

    $(document).keypress (e) ->
      if not $('input:text').is(':focus')
        scroll_to_bottom()
        update_wordcount $texteditor

        $current_line.html( $current_line.html() + get_char_from_keycode(e) )

        if is_newline(event)
          $texteditor.append document.createElement 'p'
          $current_line.addClass 'pale'
          $current_line = $($texteditor.children()[$texteditor.children().length - 1])
          $current_line.text


  scroll_to_bottom = ->
    $('html, body').animate { scrollTop: $(document).height() }, 'fast'


  get_char_from_keycode = (event) ->
    if is_newline(event) then '\n' else String.fromCharCode(event.which)


  is_newline = (event) ->
    event.keyCode is 13


  is_space = (event) ->   # True on newlines, spaces, and tabs.
    is_newline(event) or (event.keyCode is 32) or (event.keyCode is 9)


  update_wordcount = ($texteditor) ->
    $('#wordcount').text "#{get_wordcount $texteditor} words"


  get_wordcount = ($div) ->
    words = $div.text().split(/\s+/g)
    words.length


  prevent_backspace = ->
    $(document).on 'keydown', (e) ->
      e.preventDefault() if e.which == 8 and !$(e.target).is('input, textarea')


$ ->
  if gon.controller is 'entries' and gon.action is 'freewrite'
    btn = $('input#start-stop')
    texteditor = new TextEditor '#texteditor'
    btn.click (e) ->
      if btn.hasClass 'stop'
        $('#entry_body').val texteditor.plaintext()
