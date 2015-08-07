class Tiles
  constructor: (wrapper_selector = '.tiles', tile_selector = '.tile') ->
    constructor(wrapper_selector, tile_selector)

  constructor = (wrapper_selector, tile_selector) ->
    @wrapper = $(wrapper_selector)[0]
    @tiles = $(tile_selector)
    @options = options()
    position_blocks()
    $(window).resize(position_blocks)

  position_blocks = ->
    setup()
    for tile, i in @tiles
      $(tile).outerWidth(@col_width)
      $(tile).css
        'left': "#{left(i)}px"
        'top': "#{top(i)}px"
    $(@wrapper).animate({ opacity: 1 }, 'fast', 'linear')

  top = (index) ->
    val = @margin
    above_index = index - @col_count
    unless (above_index < 0)
      $tile_above = $(@tiles[above_index])
      val += $tile_above.offset().top + $tile_above.height() - $tile_above.parent().offset().top
    val

  left = (index) ->
    col = index % @col_count
    (col + 1) * @margin + col * @col_width

  setup = ->
    window_width = $(window).width()
    wrapper_width = $(@wrapper).width()
    @margin = parseInt(@options.margin, 10)  # Parse in base 10
    for a in @options.adjustments
      if window_width < a.max_width or a.max_width == null
        @col_count = a.col_count
        @col_width = (wrapper_width - @margin * (@col_count + 1)) / (@col_count )
        break

  options = ->
    options = {
      margin: '10px'
      adjustments: [
        { max_width: 768,  col_count: 1 }
        { max_width: 1200, col_count: 2 }
        { max_width: null, col_count: 3 }
      ]
    }

$ ->
  tiles = new Tiles