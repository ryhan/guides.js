# guides.coffee

class Guide

  options:
    grid:
      align: "center" # || "left" || "right"
      x:
        major: 240
        minor: 60
        gutter: 10
      y:
        major: 80
        minor: 20
        gutter: 0

  constructor: (options ={})->
    $.extend @options, options
    @show()

  show: ->
    @_createCanvas() unless @canvas
    @canvas.style.visbility = "visible"

  hide: ->
    @canvas.style.visbility = "hidden"

  update: ->
    console.log("updating")
    @canvas.width = Math.max document.body.clientWidth, window.innerWidth
    @canvas.height = Math.max document.body.clientHeight, window.innerHeight
    @_drawGridlines()

  _drawGridlines: ->
    context = @canvas.getContext '2d'

    # Gutters
    context.strokeStyle = "rgba(52, 141, 190, 0.2)"

    if @options.grid.x.gutter > 0
      context.lineWidth = @options.grid.x.gutter
      @_drawGrid context, @options.grid.x.major, 0 

    if @options.grid.y.gutter > 0
      context.lineWidth = @options.grid.y.gutter
      @_drawGrid context, 0, @options.grid.y.major

    # Minor lines
    context.strokeStyle = "rgba(0,0,0,0.2)"
    context.lineWidth = 1
    @_drawGrid context, @options.grid.x.minor, @options.grid.y.minor

    # Major lines
    context.strokeStyle = "rgba(0, 131, 255, 0.5)"
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
    @canvas.style['z-index'] = 9999

    @update();

    document.body.appendChild @canvas
    $(window).resize () => @update()
