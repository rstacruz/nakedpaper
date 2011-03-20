NN.EntryView = NN.View.extend
  templates:
    toolbar:
      _.template """
        <nav class="toolbar">
          <a class="back">&larr;</a>
        </nav>
      """

  events:
    'click a.back':   'onBack'

  initialize: ->
    @$el = $ @el

    @_spawnToolbar()
    @_cureLinks()

  _spawnToolbar: ->
    @$toolbar = @templates.toolbar()
    @$el.append @$toolbar

  # Make all links open in a new window.
  _cureLinks: ->
    @$('a').each ->
      $(this).attr 'target', '_blank'

  onBack: (e) ->
    history.go -1
    false

$('.news-pane.entry').livequery ->
  new NN.EntryView el: this
