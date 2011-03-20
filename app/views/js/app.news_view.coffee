NN.FeedView = NN.View.extend
  events:
    'click .views a':  'onSwitchView'

  initialize: ->
    @$el      = $ @el
    @$entries = @$ '.entries'
    @$views   = @$ '.views'

    @subtypes =
      'line':    NN.LineFeedView
      'compact': NN.CompactFeedView

    @switchTo @subtypes['compact']

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

  buildView: ->
    # virtual

  # Gets the entries model.
  entries: ->
    _.map @$entries.find('article'), ($e) ->
      $e    = $($e)
      entry =
        href    : $e.find('h2 a').attr('href')
        title   : $e.find('h2 a').html()
        image   : $e.find('img.image').attr('src')
        summary : $e.find('p.summary').html()
        content : $e.find('p.content').html()

  onSwitchView: (e) ->
    $target = $(e.target)
    view    = $target.attr('href').substr(1)
    view    = @subtypes[view]

    @switchTo view  if view?
    false

NN.LineFeedView =
  classname: 'line'

  template:
    _.template """
    <% _.each(entries, function(e) { %>
      <article>
        <a href="<%= e.href %>">
          <%= e.title %>
        </a>
      </article>
    <% }); %>
    """

  buildView: ->
    @$view = $("<div class='view'>")
    @$view.html @template('entries': @entries())

    @$el.append @$view

NN.CompactFeedView =
  classname: 'compact'

  buildView: ->
    @$view = $("<div class='view'>")
    @$view.html @$entries.html()

    @$el.append @$view

$('.news-pane.feed').livequery ->
  new NN.FeedView el: this
