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

