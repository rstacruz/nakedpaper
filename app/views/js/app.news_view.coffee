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

  # Override me if you need to
  buildView: ->
    @$view = $("<div class='view'>")
    @$view.html @template('entries': @entries())

    @$el.append @$view

  # Gets the entries model.
  entries: ->
    _.map @$entries.find('article'), ($e) ->
      $e    = $($e)
      entry =
        href    : $e.find('>.title').attr('href')
        title   : $e.find('>.title').html()
        image   : $e.find('>.image').attr('src')
        summary : $e.find('>.summary').html()
        content : $e.find('>.content').html()

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

NN.CompactFeedView =
  classname: 'compact'

  template:
    _.template """
    <% _.each(entries, function(e) { %>
      <article>
        <% if (e.image) { %>
          <a class="image" href="<%= e.href %>" style="background-image: 
          url(<%= e.image %>);"></a>
        <% } %>

        <h2>
          <a href="<%= e.href %>">
            <%= e.title %>
          </a>
        </h2>

        <p class="summary"><%= e.summary %></p>
      </article>
    <% }); %>
    """

$('.news-pane.feed').livequery ->
  new NN.FeedView el: this
