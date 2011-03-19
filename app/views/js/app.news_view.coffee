NN.NewsView = NN.View.extend
  initialize: ->
    @$el = $ @el

$('#news').livequery ->
  NN.News = new NN.NewsView el: this
