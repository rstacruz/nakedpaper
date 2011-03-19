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

$.ajaxSetup
  timeout: 15000
