# guides.coffee

class GridSystem

  # Defaults
  options:
    grid:
      align: "center" # || "left"
      colors:
        major: "rgba(0, 131, 255, 0.5)"
        minor: "rgba(0,0,0,0.2)"
        gutter: "rgba(52, 141, 190, 0.2)"
      x:
        major: 240
        minor: 60
        gutter: 20
      y:
        major: 80
        minor: 20
        gutter: 0

  constructor: (gridOptions ={})->
    $.extend @options.grid, gridOptions
    @show()

  show: ->
    @_createCanvas() unless @canvas
    @canvas.style.display = "block"
    @canvas.style['z-index'] = 9999

  hide: ->
    @canvas.style.display = "none"
    @canvas.style['z-index'] = -1

  toggle: ->
    if @canvas.style.display != "block"
      @show()
    else
      @hide()

  update: ->
    console.log("updating");
    @canvas.width = window.innerWidth
    @canvas.height = Math.max document.body.scrollHeight, window.innerHeight
    @_drawGridlines()

  _drawGridlines: ->
    context = @canvas.getContext '2d'

    # Gutters
    context.strokeStyle = @options.grid.colors.gutter

    if @options.grid.x.gutter > 0
      context.lineWidth = @options.grid.x.gutter
      @_drawGrid context, @options.grid.x.major, 0 

    if @options.grid.y.gutter > 0
      context.lineWidth = @options.grid.y.gutter
      @_drawGrid context, 0, @options.grid.y.major

    # Minor lines
    context.strokeStyle = @options.grid.colors.minor
    context.lineWidth = 1
    @_drawGrid context, @options.grid.x.minor, @options.grid.y.minor

    # Major lines
    context.strokeStyle = @options.grid.colors.major
    context.lineWidth = 1
    @_drawGrid context, @options.grid.x.major, @options.grid.y.major


  _drawGrid: (context, xUnit, yUnit) ->
    left = 0
    top = 0

    if @options.grid.align == 'center'
      left = @canvas.width /2 % xUnit

    if yUnit > 0
      while top < @canvas.height
        context.beginPath()
        context.moveTo 0, top
        context.lineTo @canvas.width, top
        context.stroke()
        top += yUnit

    if xUnit > 0
      while left < @canvas.width
        context.beginPath()
        context.moveTo left, 0
        context.lineTo left, @canvas.height
        context.stroke()
        left += xUnit

  _createCanvas: ->
    @canvas = document.createElement("canvas")
    @canvas.className = "guides"
    @canvas.style.position = "absolute"
    @canvas.style.margin = 0
    @canvas.style.top = 0
    @canvas.style.left = 0

    @update();

    document.body.appendChild @canvas
    $(window).resize () => @update()
