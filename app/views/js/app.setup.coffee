# Loading
$(document).bind 'after_navigate', (e) ->
  NN.loader.stop()

$(document).ajaxError (e, xhr, settings, exception) ->
  if exception == 'abort'
  else if  exception == 'timeout'
    alert "Timeout. Oops!"
  else
    alert "Something went wrong. Oops."

  $(document).trigger 'after_navigate'

$('[title]').livequery ->
  $(this).tipTip
    delay: 0, edgeOffset: 5, fadeIn: 80, maxWidth: "300px"

$.ajaxSetup
  timeout: 15000
