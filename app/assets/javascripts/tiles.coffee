class window.Tiles

  ##### PUBLIC METHODS ########################################################

  constructor: (options = {}, wrapper_selector = '.tiles', tile_selector = '.tile') ->
    constructor(options, wrapper_selector, tile_selector)

  update: ->
    update()

  ##### PRIVATE METHODS ########################################################

  constructor = (options, wrapper_selector, tile_selector) ->
    @wrapper_selector ||= wrapper_selector
    @tile_selector    ||= tile_selector
    @wrapper = $(@wrapper_selector)[0]
    @tiles   = $(@tile_selector)
    @options = build_options(options)
    position_blocks()
    $(window).resize(position_blocks)

  update = ->
    constructor(@options, @wrapper_selector, @tile_selector)

  position_blocks = ->
    setup()
    for tile, i in @tiles
      $(tile).outerWidth(@col_width)
      $(tile).css
        'left': "#{left(i)}px"
        'top': "#{top(i)}px"
    $(@wrapper).animate({ opacity: 1 }, 'fast', 'linear')

  top = (index) ->
    row = parseInt(index / @col_count)
    above_index = index - @col_count
    from_margin = @margin * row
    unless (above_index < 0) || ((tile_above = @tiles[above_index]) == undefined)
      tile_above_top = $(tile_above).offset().top - $(tile_above).parent().offset().top
      tile_above_bottom = tile_above_top + $(tile_above).height() - @margin * (row - 1)
    from_margin + (tile_above_bottom || 0)

  left = (index) ->
    col = index % @col_count
    from_margin = @margin * (col + 1)
    from_body = col * @col_width
    from_margin + from_body

  setup = ->
    window_width = $(window).width()
    wrapper_width = $(@wrapper).width()
    @margin = parseInt(@options.margin, 10)  # Parse in base 10
    for a in @options.adjustments
      if window_width < a.max_width or a.max_width == null
        @col_count = a.col_count
        @col_width = (wrapper_width - @margin * (@col_count + 1)) / (@col_count )
        break

  build_options = (options) ->
    defaults = {
      margin: '10px'
      adjustments: [
        { max_width: 768,  col_count: 1 }
        { max_width: 1200, col_count: 2 }
        { max_width: null, col_count: 3 }
      ]
    }
    $.extend(defaults, options)