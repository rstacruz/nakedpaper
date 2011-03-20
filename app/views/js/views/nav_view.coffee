NN.NavView = NN.View.extend
  initialize: ->
    @$el = $ @el
    @fetch()  if @isEmpty()

  isEmpty: ->
    $.trim(@$el.html()) == ''
 
  fetch: ->
    self = this
    @$el.html 'Fetching data...'

    $.get '/_feeds', (data) ->
      self.$el.html data

$('#feeds').livequery ->
  NN.Nav = new NN.NavView el: this
