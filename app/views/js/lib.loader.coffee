NN.loader =
  start: ->
    $("body").addClass 'loading'
    @$loader().show()

  stop: ->
    $("body").removeClass 'loading'
    @$loader().hide()

  $loader: ->
    return $("#loading")  if ($("#loading").length)

    el = $("<div id='loading'>Loading...</div>")
    $("body").append el
    el

_.bindAll [NN.loader.start, NN.loader.stop]

