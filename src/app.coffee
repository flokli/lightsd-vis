require('jquery')
paper = require('paper')
reconnectingWebSocket = require('reconnecting-websocket')

require('./style.less')

rasterToJSON = (message) ->
  data = JSON.parse(message.data).values
  line = new paper.Raster
    size:
      width: data.length
      height: 1

  for light, i in data
    do (light) ->
      line.setPixel(i, 0, new paper.Color(light[0] / 255, light[1] / 255, light[2] / 255))
  return line


class Waterfall
  constructor: (height) ->
    @buffer = (null for n in [0..height-1])

  push: (raster) ->
    @buffer.unshift(raster)
    @buffer.pop()?.remove()

    for raster, i in @buffer
      do (raster) ->
        raster?.position = new paper.Point(0.5 * raster.width, i)
    return @

class Stream
  constructor: (bufferSize) ->
    @waterfall = new Waterfall(bufferSize)

  connect: (uri) ->
    @ws = new reconnectingWebSocket(uri)
    @ws.timeoutInterval = 500
    @ws.onmessage = (message) =>
      raster = rasterToJSON(message)
      @waterfall.push(raster)
      paper.view.update()
      paper.view.draw()

  disconnect: () ->
    @ws.close()


$(document).ready ->
  canvas = $('<canvas data-paper-resize="true">')[0]

  $('body').append(canvas)

  paper.setup(canvas)

  feed = new Stream(300)
  feed.connect('ws://localhost:9000')
