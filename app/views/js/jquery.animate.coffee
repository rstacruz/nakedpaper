(($) ->
  $.fn.ani = (to) ->
    $(this).removeClass 'fade slide in out'
    $(this).addClass to
) jQuery

