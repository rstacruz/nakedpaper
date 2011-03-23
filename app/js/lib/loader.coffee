window.NN ||= {}

# The loader thing. Manages the showing and hiding of the
# "Loading..." indicator.
#
# == Usage
#
#   NN.loader.start()
#   NN.loader.stop()
#
NN.loader =
  count: 0

  start: ->
    @count++
    $("body").addClass 'loading'
    @$loader().show()

  stop: ->
    @count--

    if @count <= 0
      @count = 0
      $("body").removeClass 'loading'
      @$loader().fadeOut()

  $loader: ->
    return $("#loading")  if ($("#loading").length)

    el = $("<div id='loading'>Loading...</div>")
    $("body").append el
    el

_.bindAll [NN.loader.start, NN.loader.stop]

