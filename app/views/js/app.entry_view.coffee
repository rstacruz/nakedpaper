NN.EntryView = NN.View.extend
  events:
    'click a.back':  'onBack'

  initialize: ->
    @$el = $ @el

  onBack: (e) ->
    history.go -1
    false

$('.news-pane.entry').livequery ->
  new NN.EntryView el: this
