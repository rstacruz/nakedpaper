class NN.NavView extends NN.View
  initialize: ->
    @$el = $ @el
    @fetch()  if @isEmpty()

  isEmpty: ->
    $.trim(@$el.html()) == ''
 
  fetch: ->
    NN.loader.start()

    $.get '/_feeds', (data) =>
      NN.loader.stop()
      @$el.html data
      @$el.ani('fade in')

$('#feeds').livequery ->
  NN.Nav = new NN.NavView el: this
