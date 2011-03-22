# This is spawned by the NN.Feed model
class NN.FeedView extends NN.View
  events:
    'click .views a':  'onSwitchView'

  # The model (NN.Feed instance)
  # This is always set, don't worry
  model: null

  classname: 'compact'

  initialize: ->
    @$el      = $ @el
    @$views   = @$ '.views'

    @subtypes =
      'line':    NN.LineFeedView
      'compact': NN.CompactFeedView

    @switchTo @subtypes['compact']

  # The views toolbar (<nav>)
  $views: undefined

  # The scrollable area. (<div>)
  $view: undefined

  # Switches to a given view.
  # @example  news.switchTo NN.LineFeedView
  switchTo: (view) ->
    @destroyView()

    # Switch
    _.extend this, view
    @$el.attr 'class', "news-pane feed #{@classname}"
    @buildView()

    # Activate the button
    @$views.find('.active').removeClass 'active'
    @$views.find("a[href=##{@classname}]").addClass 'active'

  # Removes the view pane from the DOM.
  # Called before switching.
  destroyView: ->
    view = @$ '.view'
    view.remove()

  # Override me if you need to.
  # This is expected to set @$view
  buildView: ->
    @$view = $("<div class='view'>")
    @$view.html @template('entries': @getEntries())

    @$el.append @$view

  # Gets the entries model. [NN.Entry[]]
  getEntries: ->
    @model.getEntriesList()

  onSwitchView: (e) ->
    $target = $(e.target)
    return false  if $target.is('.active')

    view    = $target.attr('href').substr(1)
    view    = @subtypes[view]

    @switchTo view  if view?
    false
